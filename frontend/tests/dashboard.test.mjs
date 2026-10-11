import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import vm from 'node:vm';
import ts from 'typescript';

const element = () => ({ innerHTML: '', textContent: '', hidden: false, children: [], handlers: {},
  addEventListener(name, callback) { this.handlers[name] = callback; },
  append(child) { this.children.push(child); },
  replaceChildren() { this.children = []; },
});
const ids = ['app', 'invite-feedback', 'invite-form', 'new-code', 'invite-code',
  'logout', 'logout-feedback', 'dismiss-code', 'copy-code', 'refresh-access',
  'invites-list', 'installations-list', 'quota-mib', 'video-estimate'];
const nodes = Object.fromEntries(ids.map(id => ['#' + id, element()]));
Object.assign(nodes['#quota-mib'], { value: '1024', valueAsNumber: 1024, validity: { valid: true } });
const calls = [];
const source = readFileSync(new URL('../src/main.ts', import.meta.url), 'utf8');
const script = ts.transpileModule(source, { compilerOptions: { target: ts.ScriptTarget.ES2022,
  module: ts.ModuleKind.ES2022 } }).outputText.replace(/^import .*;\s*$/gm, '');
vm.runInNewContext(script, {
  document: { querySelector: selector => nodes[selector], createElement: element },
  fetch: async (path, options) => {
    calls.push({ path, method: options.method });
    return { ok: true, status: 200, json: async () => path.endsWith('/invites')
      ? [{ id: 'dummy-invite', label: 'Dummy', expires_at: '2099-01-01', redeemed_at: null, revoked_at: null }]
      : [{ id: 'dummy-installation', installation_name: 'Dummy', revoked_at: null, used_bytes: 0, quota_bytes: 1024, used_uploads: 0, quota_uploads: 1 }] };
  },
});
await new Promise(resolve => setImmediate(resolve));
assert.deepEqual(calls, [
  { path: '/api/v1/admin/invites', method: 'GET' },
  { path: '/api/v1/admin/installations', method: 'GET' },
]);
assert.match(nodes['#app'].innerHTML, /<h1>Admin dashboard<\/h1>/);
assert.doesNotMatch(nodes['#app'].innerHTML, /workspace-title|api-status|<footer>|class="mark"/);
for (const name of ['label', 'hours', 'mib', 'uploads']) {
  assert.ok(nodes['#app'].innerHTML.includes(`name="${name}"`));
}
for (const selector of ['#logout', '#refresh-access', '#copy-code', '#dismiss-code']) {
  assert.equal(typeof nodes[selector].handlers.click, 'function');
}
assert.equal(typeof nodes['#invite-form'].handlers.submit, 'function');
assert.match(nodes['#video-estimate'].textContent, /≈ 214 videos at 5 MB each; upload count also applies/);
for (const [value, number, valid, expected] of [
  ['10', 10, true, '≈ 2 videos'],
  ['1', 1, true, '≈ 0 videos'],
  ['', NaN, false, 'Enter a valid quota'],
  ['-10', -10, false, 'Enter a valid quota'],
  ['1.5', 1.5, false, 'Enter a valid quota'],
  ['102401', 102401, false, 'Enter a valid quota'],
  ['Infinity', Infinity, true, 'Enter a valid quota'],
]) {
  Object.assign(nodes['#quota-mib'], { value, valueAsNumber: number, validity: { valid } });
  nodes['#quota-mib'].handlers.input();
  assert.ok(nodes['#video-estimate'].textContent.startsWith(expected));
  assert.doesNotMatch(nodes['#video-estimate'].textContent, /NaN|Infinity|≈ -/);
}
assert.match(nodes['#app'].innerHTML, /aria-describedby="video-estimate"/);
for (const selector of ['#invites-list', '#installations-list']) {
  assert.equal(nodes[selector].children.length, 1);
  assert.equal(nodes[selector].children[0].children[0].textContent, 'Revoke');
  assert.equal(typeof nodes[selector].children[0].children[0].handlers.click, 'function');
}
console.log('Dashboard controls and live video estimates passed with default, changed and invalid quotas; no health request or mutation.');
