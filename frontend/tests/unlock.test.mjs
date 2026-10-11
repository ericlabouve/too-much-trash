import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import vm from 'node:vm';

const html = readFileSync(new URL('../../backend/caddy/admin/unlock.html', import.meta.url), 'utf8');
const script = html.match(/<script>([\s\S]*?)<\/script>/)[1];
const node = () => ({ value: '', textContent: '', attributes: {}, handlers: {},
  setAttribute(name, value) { this.attributes[name] = value; },
  addEventListener(name, handler) { this.handlers[name] = handler; } });
const input = node(), toggle = node(), form = node(), message = node();
input.type = 'password'; input.value = 'DUMMY-TOKEN-NOT-A-CREDENTIAL';
const nodes = { '#token': input, '#toggle-token': toggle, '#unlock-form': form, '#message': message };
let submissions = 0, navigations = 0;
vm.runInNewContext(script, {
  document: { querySelector: selector => nodes[selector] },
  fetch: async () => { submissions++; return { ok: false }; },
  location: { replace: () => { navigations++; } },
});
toggle.handlers.click();
assert.equal(input.type, 'text');
assert.equal(toggle.attributes['aria-label'], 'Hide token');
assert.equal(toggle.attributes['aria-pressed'], 'true');
toggle.handlers.click();
assert.equal(input.type, 'password');
assert.equal(toggle.attributes['aria-label'], 'Show token');
assert.equal(toggle.attributes['aria-pressed'], 'false');
assert.equal(input.value, 'DUMMY-TOKEN-NOT-A-CREDENTIAL');
assert.equal(submissions, 0);
toggle.handlers.click();
await form.handlers.submit({ preventDefault() {} });
assert.equal(input.type, 'password');
assert.equal(input.value, '');
assert.equal(submissions, 1);
assert.equal(navigations, 0);
console.log('Token visibility, value preservation, no-submit and submit-remasking checks passed using dummy text.');
