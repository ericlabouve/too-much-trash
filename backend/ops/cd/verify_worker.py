"""Bounded synthetic worker smoke test; no invitations or installation records.

Runs inside the production worker, exercises Prefect and S3 with an image and a
short generated video, then removes only these uniquely named test objects.
"""
from pathlib import Path
import subprocess

DOCKER = "/usr/local/bin/docker" if Path("/usr/local/bin/docker").exists() else "docker"
FIXTURE = r'''
import logging, pathlib, subprocess, tempfile, uuid
logging.disable(logging.CRITICAL)
from PIL import Image
from worker import storage, BUCKET, process_capture
client=storage()
with tempfile.TemporaryDirectory() as directory:
    folder=pathlib.Path(directory)
    image=folder/'synthetic.png'
    Image.new('RGB',(64,64),(42,114,185)).save(image)
    video=folder/'synthetic.mp4'
    subprocess.run(['ffmpeg','-v','error','-f','lavfi','-i','color=c=blue:s=64x64:d=0.2',
                    '-c:v','libx264','-pix_fmt','yuv420p',str(video)],check=True,capture_output=True)
    for source, kind, mime in ((image,'image','image/png'),(video,'video','video/mp4')):
        capture=str(uuid.uuid4())
        original='cd-validation/'+capture+'/'+source.name
        poster='processed/'+capture+'/poster.jpg'
        try:
            client.upload_file(str(source),BUCKET,original,ExtraArgs={'ContentType':mime})
            key,result=process_capture(capture,original,mime,kind)
            assert key==poster
            assert client.head_object(Bucket=BUCKET,Key=poster)['ContentLength']>0
            if kind=='image': assert result=={'width':64,'height':64}
            else: assert 0<float(result['duration_seconds'])<1
        finally:
            client.delete_objects(Bucket=BUCKET,Delete={'Objects':[{'Key':original},{'Key':poster}]})
print('TMT_SMOKE_PASS')
'''


def verify():
    result = subprocess.run([DOCKER, "exec", "-i", "too-much-trash-worker-1", "python", "-"],
                            input=FIXTURE.encode(), stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            timeout=180)
    if result.returncode or b"TMT_SMOKE_PASS" not in result.stdout:
        raise RuntimeError("Synthetic worker smoke failed; diagnostics withheld")
    print("PASS: image/video processing, Prefect and S3 poster output; synthetic objects removed.")


if __name__ == "__main__":
    verify()
