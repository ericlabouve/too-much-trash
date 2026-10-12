import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import vm from 'node:vm';
import ts from 'typescript';

const element = () => ({ innerHTML: '', textContent: '', hidden: false, children: [], handlers: {}, attributes: {},
  setAttribute(name, value) { this.attributes[name] = value; },
  addEventListener(name, callback) { this.handlers[name] = callback; },
  append(child) { this.children.push(child); },
  replaceChildren() { this.children = []; },
});
const ids = ['app', 'invite-feedback', 'invite-form', 'new-code', 'invite-code',
  'logout', 'logout-feedback', 'dismiss-code', 'copy-code', 'refresh-access',
  'invites-list', 'installations-list', 'quota-mib', 'video-estimate',
  'toggle-revoked-invites', 'toggle-revoked-installations', 'invites-empty', 'installations-empty'];
const nodes = Object.fromEntries(ids.map(id => ['#' + id, element()]));
Object.assign(nodes['#quota-mib'], { value: '1024', valueAsNumber: 1024, validity: { valid: true } });
const calls = [];
let inviteData = [{ id: 'dummy-invite', label: 'Dummy', expires_at: '2099-01-01', redeemed_at: null, revoked_at: null }];
let installationData = [{ id: 'dummy-installation', installation_name: 'Dummy', tester_label: 'Field tester', revoked_at: null, used_bytes: 0, quota_bytes: 1024, used_uploads: 0, quota_uploads: 1 }];
const source = readFileSync(new URL('../src/main.ts', import.meta.url), 'utf8');
const script = ts.transpileModule(source, { compilerOptions: { target: ts.ScriptTarget.ES2022,
  module: ts.ModuleKind.ES2022 } }).outputText.replace(/^import .*;\s*$/gm, '');
vm.runInNewContext(script, {
  document: { querySelector: selector => nodes[selector], createElement: element },
  fetch: async (path, options) => {
    calls.push({ path, method: options.method });
    if (options.method === 'POST') {
      const data = path.includes('/invites/') ? inviteData : installationData;
      data.find(row => row.id === path.split('/')[5]).revoked_at = '2026-10-11';
      return { ok: true, status: 204 };
    }
    return { ok: true, status: 200, json: async () => structuredClone(path.endsWith('/invites') ? inviteData : installationData) };
  },
  window: { confirm: () => true },
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
assert.ok(nodes['#installations-list'].children[0].textContent.startsWith('Field tester ·'));
assert.ok(!nodes['#installations-list'].children[0].textContent.includes('dummy-installation'));
const tick = () => new Promise(resolve => setImmediate(resolve));
const refresh = async () => { nodes['#refresh-access'].handlers.click(); await tick(); };
inviteData.push(
  { ...inviteData[0], id: 'expired', label: 'Expired', expires_at: '2000-01-01' },
  { ...inviteData[0], id: 'redeemed', label: 'Redeemed', redeemed_at: '2026-10-11' },
  { ...inviteData[0], id: 'revoked', label: 'Revoked', revoked_at: '2026-10-11' },
);
installationData.push({ ...installationData[0], id: 'revoked-installation', revoked_at: '2026-10-11' });
await refresh();
assert.equal(nodes['#invites-list'].children.length, 2);
assert.equal(nodes['#installations-list'].children.length, 1);
assert.equal(nodes['#toggle-revoked-invites'].textContent, 'Expand (2)');
assert.ok(nodes['#invites-list'].children.some(row => row.textContent.includes('Expired')));
assert.ok(!nodes['#invites-list'].children.some(row => row.textContent.includes('Redeemed')));
const beforeToggle = calls.length;
nodes['#toggle-revoked-invites'].handlers.click();
assert.equal(nodes['#invites-list'].children.length, 4);
assert.equal(nodes['#installations-list'].children.length, 1);
assert.equal(nodes['#toggle-revoked-invites'].attributes['aria-expanded'], 'true');
assert.equal(nodes['#toggle-revoked-invites'].textContent, 'Expand (2)');
assert.ok(nodes['#invites-list'].children.some(row => row.textContent.includes('Redeemed')));
assert.equal(calls.length, beforeToggle);
nodes['#toggle-revoked-installations'].handlers.click();
await refresh();
assert.equal(nodes['#invites-list'].children.length, 4);
assert.equal(nodes['#installations-list'].children.length, 2);
nodes['#toggle-revoked-invites'].handlers.click();
await nodes['#invites-list'].children[0].children[0].handlers.click();
assert.equal(nodes['#invites-list'].children.length, 1);
assert.equal(nodes['#toggle-revoked-invites'].textContent, 'Expand (3)');
await nodes['#installations-list'].children[0].children[0].handlers.click();
assert.equal(nodes['#installations-list'].children.length, 2);
assert.ok(nodes['#installations-list'].children.every(row => row.children.length === 0));
nodes['#toggle-revoked-installations'].handlers.click();
assert.equal(nodes['#installations-list'].children.length, 0);
assert.equal(nodes['#installations-empty'].hidden, false);
assert.equal(nodes['#installations-empty'].textContent, 'No active installations.');
inviteData.forEach(row => { row.revoked_at = '2026-10-11'; });
await refresh();
assert.equal(nodes['#invites-list'].children.length, 0);
assert.equal(nodes['#toggle-revoked-invites'].textContent, 'Expand (4)');
assert.equal(nodes['#invites-empty'].textContent, 'No unused invitations.');
assert.equal(nodes['#invites-empty'].hidden, false);
nodes['#toggle-revoked-invites'].handlers.click();
assert.equal(nodes['#invites-list'].children.length, 4);
inviteData = []; installationData = [];
await refresh();
assert.match(nodes['#invites-empty'].textContent, /No invitations yet/);
assert.match(nodes['#installations-empty'].textContent, /No installations yet/);
assert.equal(nodes['#toggle-revoked-invites'].disabled, true);
console.log('Dashboard quota/control, redeemed/revoked history, labels, counts and empty states passed; no real requests or records.');
