---
name: design
description: Build professional, modern, accessible web UIs. Use whenever the user asks to
  create, design, restyle or review a page, component, layout, dashboard or landing page,
  or works on React, Next.js, Tailwind or shadcn/ui code.
---

# Frontend Design

Build UIs that look designed by a professional, not generated.

## Before writing code
- Read package.json: match the project's existing framework, versions and styling. Don't
  introduce a new stack into an existing project.
- For a new project, default to: Next.js (App Router) + TypeScript + Tailwind CSS + shadcn/ui
  + lucide-react icons.
- Check current docs for anything version-sensitive; don't use deprecated APIs.

## Design standards
- **Hierarchy:** one clear primary action per view; size, weight and color guide the eye.
- **Spacing:** use one consistent scale (Tailwind's); generous whitespace beats borders.
- **Typography:** max two typefaces; a clear type scale; body text 16px+, line length ~60-75ch.
- **Color:** define colors as theme tokens, never hard-coded hex in components; one accent
  color; support dark mode.
- **States:** every interactive element has hover, focus-visible, active and disabled states;
  every data view has loading, empty and error states.
- **Responsive:** mobile-first; test at 375px, 768px and 1280px.
- **Motion:** subtle and purposeful (150-300ms); respect prefers-reduced-motion.
- **Avoid the "AI look":** no default purple gradients, no emoji as icons, no lorem ipsum,
  no random mix of radii and shadows.

## Accessibility (non-negotiable)
- Semantic HTML first (button, nav, main, label); ARIA only when HTML can't express it.
- Everything works by keyboard; focus is always visible.
- Text contrast meets WCAG AA (4.5:1).
- Images have meaningful alt text; form inputs have labels.

## React / Next.js standards
- Server Components by default; add "use client" only where interactivity needs it.
- Use next/image and next/font; fetch data on the server where possible.
- Small components with one job; extract logic into custom hooks.
- Compose shadcn/ui components rather than rebuilding buttons, dialogs or inputs.

## Before finishing
Check the result against: hierarchy, spacing, states, responsive, accessibility, dark mode.
