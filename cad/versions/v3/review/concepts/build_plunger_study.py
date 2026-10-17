"""Generate schematic research concepts, not manufacturing geometry."""
from pathlib import Path
from html import escape
import json

OUT = Path(__file__).resolve().parent
parts = []


def text(x, y, value, size=18, color="#263747", weight="400"):
    parts.append(f'<text x="{x}" y="{y}" font-size="{size}" fill="{color}" font-weight="{weight}">{escape(value)}</text>')


def rect(x, y, w, h, fixed=False, fill=None):
    color = fill or ("#d97127" if fixed else "#ffc782")
    parts.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="3" fill="{color}" stroke="#9b4a16" stroke-width="2"/>')


def path(d, color="#7754a6", width=4, arrow=False, dash=False):
    parts.append(f'<path d="{d}" fill="none" stroke="{color}" stroke-width="{width}"'
                 + (' marker-end="url(#arrow)"' if arrow else '')
                 + (' stroke-dasharray="6 5"' if dash else '') + '/>')


def wheel(x, y, r=20, moving=False):
    parts.append(f'<circle cx="{x}" cy="{y}" r="{r}" fill="{"#ffc782" if moving else "#e9904f"}" stroke="#9b4a16" stroke-width="2"/>')
    parts.append(f'<circle cx="{x}" cy="{y}" r="4" fill="#9b4a16"/>')


def common(moving=False):
    # All parts orange; dark orange denotes fixed structure.
    rect(218, 192 if moving else 135, 24, 136 if moving else 193)
    for y in ([220, 266] if moving else [168, 214]):
        rect(200, y, 14, 22, True)
        rect(246, y, 14, 22, True)
    rect(193, 310, 74, 12)
    rect(190, 335, 24, 10, True)
    rect(246, 335, 24, 10, True)
    rect(218, 322, 24, 31)
    parts.append('<rect x="125" y="367" width="290" height="35" rx="7" fill="#e4e9ed" stroke="#8394a1" stroke-width="2"/>')
    parts.append('<rect x="213" y="354" width="34" height="13" rx="4" fill="#a0adb7"/>')
    text(279, 391, "PHONE", 16)
    path("M290 320 V351", "#19816c", arrow=True)
    text(310, 340, "PRESS", 15, "#19816c")
    text(30, 340, "frame stop", 16)
    path("M117 335 H181", "#647583", 1.5)
    text(30, 386, "button", 16)
    path("M91 380 L204 360", "#647583", 1.5)


def redirect(fixed_eye=False):
    if fixed_eye:
        # A fixed radiused quadrant; the cord slides on its outside face.
        parts.append('<path d="M230 247 A20 20 0 0 0 250 267 L265 267 L265 232 L230 232 Z" fill="#d97127" stroke="#9b4a16" stroke-width="2"/>')
    else:
        wheel(250, 247)
    path("M230 144 V247 A20 20 0 0 0 250 267 H537", arrow=True)
    text(443, 248, "TWINE PULL", 15, "#7754a6")
    parts.append('<circle cx="230" cy="144" r="5" fill="#7754a6"/>')


def panel(x, y, title, subtitle, lines, kind):
    parts.append(f'<g transform="translate({x},{y})">')
    parts.append('<rect x="0" y="0" width="680" height="500" rx="12" fill="#fff" stroke="#d8e0e5"/>')
    text(25, 38, title, 25, weight="700")
    text(25, 68, subtitle, 18)
    common(kind == 3)
    if kind in (1, 2, 4):
        redirect(kind == 2)
        text(337, 172, "Centered attachment", 17)
        path("M325 169 L238 148", "#647583", 1.5)
        text(337, 202, "Two short guide lands", 17)
        path("M325 206 L268 222", "#647583", 1.5)
        text(337, 292, "Fixed eye" if kind == 2 else "Fixed-axis pulley", 17)
        text(337, 314, "in front of slider", 16)
    if kind == 3:
        wheel(230, 172, moving=True)
        wheel(270, 274)
        rect(198, 280, 24, 10, True)
        path("M210 280 V172 A20 20 0 0 1 250 172 V274 A20 20 0 0 0 270 294 H537", arrow=True)
        text(431, 275, "TWINE PULL", 15, "#7754a6")
        text(325, 145, "Pulley rides on slider", 17)
        path("M316 149 L253 167", "#647583", 1.5)
        text(27, 261, "Fixed end", 16)
        path("M109 260 L201 281", "#647583", 1.5)
        text(340, 212, "Pull 2 units", 18)
        text(340, 237, "Press 1 unit (ideal)", 18)
    if kind == 4:
        rect(126, 91, 14, 28, True)
        rect(320, 91, 14, 28, True)
        path("M140 105 C176 105 181 142 218 142 M320 105 C284 105 279 142 242 142", "#d97127", 5)
        text(356, 114, "Paired printed leaves", 16)
        path("M349 110 H338", "#647583", 1.5)
    elif kind != 3:
        text(30, 113, "No added return spring", 16, "#596b78")
    text(25, 443, lines[0], 18, weight="700")
    text(25, 473, lines[1], 17)
    parts.append('</g>')


parts.append('<svg xmlns="http://www.w3.org/2000/svg" width="1440" height="1260" viewBox="0 0 1440 1260"><defs><marker id="arrow" markerWidth="9" markerHeight="9" refX="7" refY="4" orient="auto-start-reverse"><path d="M0 0 L8 4 L0 8" fill="none" stroke="context-stroke" stroke-width="1.5"/></marker></defs><rect width="1440" height="1260" fill="#f4f6f7"/><g font-family="Arial,Helvetica,sans-serif" stroke-linecap="round" stroke-linejoin="round">')
text(30, 46, "Option A evolved: four compact plunger concepts", 32, weight="700")
text(30, 79, "Schematic side projections • press downward • gaps exaggerated • cord and pulley may sit ahead of the slider in depth", 18)
text(30, 111, "Orange: printed parts (dark = fixed)     Purple: twine     Green: output motion     No rubber-band return in these sketches", 18)
panel(25, 134, "A1  Centered pull + rotating pulley", "Best starting point for testing button-only return.",
      ["One slider + one wheel + captive printed axle.", "Less cord rubbing; axle friction and print fit still matter."], 1)
panel(735, 134, "A2  Centered pull + fixed curved eye", "Fewest parts; most compact routing candidate.",
      ["One slider; rounded cord guide integral with frame.", "Sliding twine friction makes button-only return harder."], 2)
panel(25, 654, "A3  Moving pulley + guided plunger", "2:1 input travel / output travel; two wheels total.",
      ["Half the stroke, about twice the output force (ideal).", "More friction and depth; button must back-drive the tackle."], 3)
panel(735, 654, "A4  A1 + light printed return leaves", "Slider stays rigid; replaceable leaves help it retract.",
      ["No rubber band; restores a small gap after release.", "Leaf stiffness, PLA creep and fatigue need qualification."], 4)
text(30, 1190, "All four: frame-referenced press stop + settable button gap + a separate excess-pull provision at the trigger or input.", 19, weight="700")
text(30, 1222, "Button-only return can restore button height, not an air gap. A stop limits displacement; it does not absorb continuing trigger travel.", 18)
text(30, 1247, "Research concepts • 2026-10-07 • unscaled and unvalidated • current V3 rocker CAD remains unchanged", 16, "#596b78")
parts.append('</g></svg>')
svg = ''.join(parts)
(OUT / 'plunger-concepts.svg').write_text(svg)

sources = [
    {"title": "igus: eccentric drive loads and binding", "url": "https://www.igus.com/company/5-linear-guide-installation-tips-ca", "finding": "Keep the drive near the guide axis and avoid overconstraining parallel guides. Their numeric 2:1 rule is specific to their bearings, not a PLA design limit."},
    {"title": "OMRON: tactile switch precautions", "url": "https://omronfs.omron.com/en_US/ecb/products/pdf/precautions_tactile.pdf", "finding": "Straight actuation and avoidance of excess force after the switch stops. General design guidance only: not an iPhone switch specification."},
    {"title": "MIT: capstan friction", "url": "https://ocw.mit.edu/courses/2-141-modeling-and-simulation-of-dynamic-systems-fall-2006/09bbd00ad1a816a401f166e35fbaf231_capstan_amplifie.pdf", "finding": "Cord sliding around a fixed surface incurs friction; unknown twine/PLA friction prevents a numerical return prediction."},
    {"title": "Sava: pulley design", "url": "https://www.savacable.com/sava-expertise/pulleys-design-information", "finding": "Pulley bend diameter matters. Published wire-rope diameter ratios must not be transferred to unspecified textile twine."},
    {"title": "Sharkey et al.: printed flexure translation stage", "url": "https://arxiv.org/abs/1509.05394", "finding": "Printed flexures are a demonstrated mechanism family. This does not validate these leaf dimensions or lifetime."},
    {"title": "Fischbach and Weinberg: flexural creep of printed PLA", "url": "https://arxiv.org/abs/2302.11240", "finding": "PLA flexural creep and aging are experimentally relevant; permanent spring preload needs validation."},
]
spec = {
    "date": "2026-10-07", "status": "research concepts only; no replacement selected or CAD implemented",
    "user_direction": "Develop Option A sliding-plunger alternatives; investigate phone-button return without rubber bands.",
    "recommendation": "A1 first, with provision for optional A4 return leaves",
    "orientation": "Schematic side projections, press toward phone downward; depth offsets are not dimensioned.",
    "concepts": ["A1 centered pull and fixed-axis rotating pulley", "A2 centered pull and fixed rounded eye", "A3 moving pulley with 2:1 stroke reduction", "A4 A1 plus paired printed return leaves"],
    "return_condition": "Button restoring force must exceed slider stiction, reflected cord/pulley resistance, residual input tension and adverse gravity throughout release. Button cannot restore a positive air gap by itself.",
    "common_requirements": ["Force applied near slider axis", "Short separated guide lands and relieved non-bearing surfaces", "Captured slider and retained twine", "Removable access for cleaning", "Settable gap independent of twine knot", "Frame stop adjusted to measured button travel", "Separate input travel accommodation; a hard stop alone is insufficient"],
    "excess_pull_candidate": "A replaceable printed flexure at trigger-side twine attachment could take up remaining trigger displacement after the slider stop engages. Its stroke and force rise must be designed from measurements. This is not a constant-force limiter and must not bottom out in normal travel.",
    "unknowns": ["Actual phone model/case and return-force curve", "Button operating and allowable travel", "Trigger cord travel and residual tension", "Twine diameter, stiffness and friction", "Printed sliding and axle fit", "Frame deflection under pull"],
    "sources": sources,
}
(OUT / 'plunger-concepts.spec.json').write_text(json.dumps(spec, indent=2) + '\n')
items = ''.join(f'<li><a href="{s["url"]}">{escape(s["title"])}</a> — {escape(s["finding"])}</li>' for s in sources)
html = '''<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>V3 plunger concepts</title><style>body{margin:0;background:#f4f6f7;color:#263747;font:17px/1.55 system-ui,sans-serif}main{max-width:1440px;margin:auto}img{display:block;width:100%;height:auto}article{max-width:960px;margin:20px auto 60px;padding:0 24px}h2{font-size:23px}li{margin:12px 0}a{color:#215d94}table{border-collapse:collapse;width:100%}td,th{text-align:left;border-bottom:1px solid #c8d2da;padding:10px;vertical-align:top}</style><main><img src="plunger-concepts.svg" alt="Four annotated plunger mechanism concepts"><article>
<h2>Recommendation: A1, with room for optional A4 return leaves</h2>
<p>A1 keeps the pull on the plunger axis and uses a rotating wheel to turn the cord. Use a captive keyed slider, two separated bearing lands with relieved space between them, a cord-retaining wheel cover and accessible clean-out openings. These are proposed design features, not validated dimensions. The side projection places the wheel in front of the slider in depth; that packaging must be checked in CAD.</p>
<h2>Can the phone button provide the return?</h2>
<p>Possibly. Throughout release, its restoring force must exceed slider stiction, cord and axle resistance, any residual trigger tension, and gravity opposing return. Button return force has not been measured. A button can push the plunger back to its released height, but cannot push it farther to establish an air gap. A captive, nearly unloaded contact may work; guaranteed clearance calls for an independent return source such as A4. A tension-only cord going slack does not positively retract the plunger.</p>
<p>The 2:1 A3 tackle uses twice the cord travel per unit of plunger travel and approximately doubles force in an ideal frictionless model. It does not solve arbitrary trigger overtravel, and return must back-drive both wheels. It is a stroke-reduction option, not a force-limiting option.</p>
<h2>Separate three functions</h2>
<table><tr><th>Function</th><th>Proposed implementation</th><th>Unresolved requirement</th></tr>
<tr><td>Position contact</td><td>Captured setup shims or a lockable carrier adjustment; retain successful printed fastener geometry if used.</td><td>Measure real phone/case button position; do not use knot tension to set the gap.</td></tr>
<tr><td>Limit press depth</td><td>Plunger shoulder lands against frame stops, diverting additional load into the frame.</td><td>Set from measured button travel; verify frame deflection does not continue pressing the button.</td></tr>
<tr><td>Allow remaining trigger motion</td><td>Candidate: a replaceable printed flexure at the trigger-side cord attachment takes up extra displacement.</td><td>Measure full trigger draw, size the flexure for that draw and force, and prevent bottoming. A spring is not a constant-force limiter.</td></tr></table>
<p>Do not obtain extra stroke by compressing a spring directly against the phone indefinitely. A frame stop alone also cannot absorb the remaining motion of a rigidly coupled trigger.</p>
<h2>What makes the compact version robust?</h2>
<ul><li>Center the cord attachment over the button reaction to reduce tipping. Avoid an offset arm like the original A sketch.</li><li>Use one keyed slider rather than two tightly fitted parallel rails. Relieve non-bearing surfaces for print variation and debris clearance; reduced contact area alone is not a guarantee of lower friction.</li><li>Print guide faces and the slider without support scars on mating surfaces; assemble separately rather than print in place.</li><li>Use a broad radiused cord groove and a captive wheel/axle. Select the smallest wheel only after checking the actual twine bending and axle drag; no textile-twine diameter is yet known.</li><li>Keep the contact face limited to the intended button; the previous 16 mm shoe should not automatically transfer to this mechanism.</li><li>A4 leaves should be replaceable and near unloaded at rest where practical. Their fatigue life and creep are unknown.</li></ul>
<h2>Evidence and limits</h2><p>Sources below inform the mechanism principles. They do not establish this phone's force/travel, the proposed print clearances, or a finished module envelope. No source found here provides a verified return-force curve for the user's phone.</p><ul>''' + items + '''</ul><p>Current V3 rocker geometry and all V1/V2 files remain unchanged. The 14 mm pocket conflicts remain outside this actuator study.</p></article></main></html>'''
(OUT / 'plunger-concepts.html').write_text(html)
