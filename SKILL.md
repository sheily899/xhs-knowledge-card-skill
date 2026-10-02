---
name: xhs-knowledge-card-skill
description: Create and edit Xiaohongshu 3:4 knowledge cards from user-confirmed Chinese copy and supplied IP assets using editable HTML/CSS. Preserve the original text, suggest visual modules, and require confirmation before semantic deletion, rewriting, or restructuring.
metadata:
  short-description: Build editable Xiaohongshu knowledge cards
---

# Xiaohongshu Knowledge Card Skill

Use this skill when the user wants to turn confirmed Chinese copy and user-provided IP images into editable Xiaohongshu knowledge cards, especially 3:4 vertical cards with a controlled visual system.

## Core contract

- Treat the user's confirmed copy as the source of truth.
- Do not silently delete, summarize, rewrite, merge, or reorder meaningful copy to make a layout fit.
- Use the user's supplied IP assets. Do not invent a replacement character or redesign the face, hair, clothing, colors, or identifying features.
- Keep the output editable in HTML/CSS first. PNG is for publishing; SVG is an exchange format and does not guarantee native text editability after Figma import.
- Prefer a clear, breathable layout over filling every blank area.
- Keep typography controlled: title, body, and emphasis are the primary levels; avoid unnecessary size variants.

## Expected input

The user normally provides plain text, not JSON. Accept text organized with simple labels such as:

- page number or page title;
- opening scene or introduction;
- definition, example, explanation, or conclusion;
- numbered or parallel items;
- requested emphasis or layout hints, if any.

If the user provides several pages, keep each page's copy separate. Ask for missing information only when it changes the result materially. Useful optional inputs are the IP image, preferred color, font, page ratio, and a reference image.

Do not require the user to understand `content.json`, `layout.json`, HTML, CSS, or the project directory structure.

## Workflow

### 1. Inventory the copy

Before designing, identify the content units without changing their wording:

- page title;
- scene or transition;
- definition or central claim;
- example and explanation;
- parallel problems, benefits, or steps;
- relationship or process chain;
- closing statement.

If a sentence can be interpreted in more than one way, preserve it and mark the uncertainty instead of guessing.

### 2. Suggest a module mapping

Choose a visual form based on meaning and reading rhythm:

| Content shape | Default module |
| --- | --- |
| Transition or complete explanation | Plain text |
| Definition or one sentence to remember | Highlight block |
| Ordered or parallel items | List |
| Four equivalent values or steps | Four-grid |
| Explicit cause-effect or process relation | Flow/chain proposal |

The first four forms are supported by the current editable prototype. A flow or relationship chain may be designed as a page-specific structure, but do not claim that it is already a universal addable module.

Ask for confirmation before:

- converting a complete paragraph into a diagram;
- reducing several sentences to keywords;
- changing the original reading order;
- combining or removing explanatory sentences;
- turning a continuous explanation into a four-grid.

If the user has already specified a module form, follow that instruction.

### 3. Build the editable card

Create or update an HTML/CSS canvas with these defaults unless the user specifies otherwise:

- 1080 × 1440, 3:4 vertical ratio;
- white background;
- dark text and one controlled accent color, normally extracted from the supplied IP;
- stable title, body, and emphasis typography;
- generous safe margins and readable line height;
- normal document flow so later modules move down when an earlier module grows.

Do not use absolute positioning for the whole page when document flow can preserve editability. Absolute positioning is acceptable for deliberate local decoration or the supplied IP layer.

### 4. Keep editing controls understandable

The editable page should make the common operations obvious:

- click text to edit;
- add a module and choose its form;
- delete only user-added modules by default;
- move modules up or down;
- replace the IP image;
- drag the IP image horizontally or vertically;
- adjust image size and reset its position;
- run a layout/content check;
- export PNG or SVG.

Protect fixed original modules from accidental deletion. If the user asks to remove a fixed module, treat that as a content-structure change and make the change explicit.

### 5. Validate before delivery

Check the result in the browser and at a small mobile-preview size:

- every confirmed text block is present;
- Chinese line breaks are natural;
- no module or IP is clipped;
- no text overlaps another module or the IP;
- no custom module is empty;
- the title and key message remain readable in a thumbnail;
- the page still has breathing room;
- text has not been silently reduced below a practical reading size.

If content overflows, first adjust module proportions, spacing, or page structure. If that is not enough, report the overflow and ask whether to split or edit the copy.

## Asset rules

- Prefer user-provided PNG, JPG, or WebP assets; transparent PNG is best when the IP needs to sit on a white background.
- Reuse the supplied image rather than generating a new character.
- If the available asset does not support a requested pose, preserve the original pose and adjust the composition.
- Do not use stock people, unrelated illustrations, or decorative characters to fill space.
- Keep decorative lines, bulbs, folders, or diagrams subordinate to the copy and IP.

## Source and export rules

- Keep the HTML file as the primary editable source.
- Keep page copy and layout data separate when the project already uses `content.json` and `layout.json`.
- Do not imply that browser edits automatically write back to those data files unless that persistence has been implemented and verified.
- Export PNG for publishing.
- Export SVG for exchange or archival use, but warn that HTML/CSS effects and `foreignObject` may render differently in other tools.
- Treat Figma as optional follow-up editing. Verify the actual import result before claiming that text remains natively editable.

## Boundaries

This skill can organize confirmed copy, propose modules, build editable HTML/CSS cards, reuse supplied IP assets, check common layout errors, and export deliverables.

It cannot guarantee:

- perfect one-pass layout for arbitrary text length;
- factual correctness or editorial quality of the copy;
- identical line breaks across machines with different fonts;
- automatic generation of a faithful new IP pose;
- complete Figma editability after SVG import;
- automatic persistence of temporary browser edits;
- permission to upload files to a remote repository unless the user explicitly requests it.

When an action would change the meaning of the copy or exceed the supplied assets, stop and ask for confirmation instead of guessing.

## Project resources

- Detailed usage, boundaries, and validation checklist: [README.md](README.md)
- Content chunking and confirmation rules: [references/content-structuring.md](references/content-structuring.md)
- Module selection and editing rules: [references/module-guide.md](references/module-guide.md)
- Visual system and layout baseline: [references/visual-system.md](references/visual-system.md)
- Browser editing and export limits: [references/editing-and-export.md](references/editing-and-export.md)
- Editable page 02 prototype: [outputs/skill-page02-prototype/index.html](outputs/skill-page02-prototype/index.html)
- Editable page 03 prototype: [outputs/skill-page03-prototype/index.html](outputs/skill-page03-prototype/index.html)
