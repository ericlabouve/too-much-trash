import argparse
import asyncio, sys
from pathlib import Path
from pymobiledevice3.lockdown import create_using_usbmux, UsbmuxLockdownClient
from pymobiledevice3.pair_records import get_preferred_pair_record
from pymobiledevice3.services.companion import CompanionProxyService
from pymobiledevice3.service_connection import ServiceConnection
from pymobiledevice3.services.installation_proxy import InstallationProxyService
from pymobiledevice3.services.streaming_zip_conduit import StreamingZipConduitService
parser = argparse.ArgumentParser(description="Inspect or install a signed Watch app through its USB-connected iPhone. Reuses existing trust; never pairs or unpairs.")
parser.add_argument('--phone', required=True, help='USB-connected iPhone UDID')
parser.add_argument('--watch', required=True, help='Paired physical Watch UDID')
parser.add_argument('--app', type=Path, help='Signed Watch .app; required with --install')
parser.add_argument('--bundle-id', default='org.toomuchtrash.app.watchkitapp')
parser.add_argument('--install', action='store_true', help='Install; default only checks trust and installed app')
args = parser.parse_args()
if args.install and (not args.app or not args.app.is_dir()):
    parser.error('--install requires an existing signed --app directory')
PHONE, WATCH, APP = args.phone, args.watch, args.app
class Relay(UsbmuxLockdownClient):
    async def create_service_connection(self, port, ssl_context=None, strip_ssl=False):
        forwarded = await self.proxy.start_forwarding_service_port(port)
        self.ports.add(port)
        if not forwarded: raise RuntimeError('No forwarded port')
        return await ServiceConnection.create_using_usbmux(PHONE, forwarded, 'USB', ssl_context=ssl_context, strip_ssl=strip_ssl)
async def main():
    phone=await create_using_usbmux(serial=PHONE, autopair=False, connection_type='USB')
    proxy=CompanionProxyService(phone)
    ports=set()
    watch=None
    try:
        record=await get_preferred_pair_record(WATCH, Path.home()/'.pymobiledevice3')
        print('Existing Watch trust record available:', bool(record), flush=True)
        if not record: raise RuntimeError('Existing Watch trust record missing; establish trust with Xcode first')
        port=await proxy.start_forwarding_service_port(62078)
        ports.add(62078)
        if not port: raise RuntimeError('Companion relay did not return a port')
        conn=await ServiceConnection.create_using_usbmux(PHONE,port,'USB')
        watch=Relay(conn, host_id=record['HostID'], identifier=WATCH, pair_record=record)
        watch.proxy=proxy; watch.ports=ports
        await watch._initialize()
        if watch.udid != WATCH:
            raise RuntimeError('Relay reached a different device; refusing installation')
        print('Device:',watch.device_class, watch.product_version, flush=True)
        valid=await watch.validate_pairing()
        print('Existing trust accepted:',valid, flush=True)
        if not valid: raise RuntimeError('Existing Watch trust rejected; no new pairing attempted')
        async with InstallationProxyService(watch) as installer:
            if args.install:
                async with StreamingZipConduitService(watch) as conduit:
                    await conduit.install(Path(APP), developer=True, handler=lambda percent: print('Install progress:', percent, flush=True))
                print('INSTALL COMPLETED', flush=True)
            apps=await installer.lookup({'BundleIDs':[args.bundle_id]})
            if args.install and args.bundle_id not in (apps or {}):
                raise RuntimeError('Install returned success but bundle lookup did not confirm it')
            print('Watch app lookup:', {k:{field:v.get(field) for field in ['CFBundleIdentifier','CFBundleVersion','ApplicationType']} for k,v in (apps or {}).items()}, flush=True)
    finally:
        if watch:
            try: await watch.close()
            except Exception: pass
        for port in ports:
            try: await asyncio.wait_for(proxy.stop_forwarding_service_port(port),5)
            except Exception: pass
        await phone.close()
try: asyncio.run(asyncio.wait_for(main(),180))
except Exception as e:
    print('FAILED:',type(e).__name__,str(e),flush=True)
    sys.exit(1)
