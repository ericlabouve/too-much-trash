import assert from 'node:assert/strict';
import { pathToFileURL } from 'node:url';

const { logoutAdmin } = await import(pathToFileURL(process.argv[2]).href);
let destination;
await logoutAdmin(async (path, options) => {
  assert.equal(path, '/api/v1/admin/session');
  assert.equal(options.method, 'DELETE');
  assert.equal(options.credentials, 'same-origin');
  assert.equal(options.cache, 'no-store');
  assert.equal(options.redirect, 'error');
  return { status: 204 };
}, path => { destination = path; });
assert.equal(destination, '/unlock');
for (const status of [200, 302, 401, 500]) {
  destination = undefined;
  await assert.rejects(logoutAdmin(async () => ({ status }), path => { destination = path; }));
  assert.equal(destination, undefined);
}
destination = undefined;
await assert.rejects(logoutAdmin(async () => { throw new Error('network unavailable'); }, path => { destination = path; }));
assert.equal(destination, undefined);
console.log('Logout success, response-failure and network-failure checks passed.');
