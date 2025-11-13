# Design Guidelines - Dashboard de Inteligência Territorial

## Design Approach
**Utility-Focused Design System**: Data-dense dashboard requiring efficiency, clarity, and consistent UI patterns for public sector managers without technical expertise. Design prioritizes functional hierarchy, data visualization clarity, and intuitive navigation.

## Core Design Principles
1. **Accessibility First**: Designed for non-technical users - clear labels, generous spacing, obvious interaction patterns
2. **Information Density**: Balance between comprehensive data display and visual breathing room
3. **Contextual AI Integration**: IA elements are prominent but not overwhelming, clearly marked with cyan accents
4. **Responsive Data Display**: All visualizations and tables adapt gracefully across devices

## Typography
**Font Family**: Inter (Google Fonts - all weights)

**Hierarchy:**
- H1 (Page/Tab Titles): 36px, Bold (700)
- H2 (Section Headers): 24px, Semibold (600)
- H3 (Card Titles, Subsections): 20px, Semibold (600)
- Body Text: 16px, Regular (400)
- Captions/Labels: 14px, Regular (400)
- KPI Numbers (Large Display): 32px, Bold (700)
- Small Data/Timestamps: 12px, Regular (400)

## Color System
**Primary Palette:**
- Navy Blue `#1e3a8a`: Main background, primary containers
- Cyan `#06b6d4`: Headlines, links, IA branding, interactive elements
- Orange `#f97316`: Primary action buttons, critical alerts
- Green `#10b981`: Success states, positive indicators, growth metrics
- Yellow `#fbbf24`: Warning states, attention indicators
- White `#ffffff`: Card backgrounds, primary text on dark backgrounds
- Gray `#6b7280`: Secondary text on light backgrounds

**Application:**
- Dashboard background: Navy Blue
- Content cards: White with `shadow-lg`
- Section dividers: Gray-200 `#e5e7eb`
- AI Analysis boxes: `rgba(6, 182, 212, 0.1)` background with `3px solid #06b6d4` top border
- Chat sidebar: White background with subtle shadow

## Layout System
**Spacing Scale**: Tailwind units of 2, 4, 8, 12, 16, 20, 24, 32 (p-2, m-4, gap-8, etc.)

**Key Measurements:**
- Chat sidebar: 300px fixed (desktop), fullscreen modal (mobile)
- Max content width: 1920px
- Card padding: p-6 (desktop), p-4 (mobile)
- Section spacing: gap-8 vertical, gap-6 horizontal
- Button height: h-12 (48px minimum touch target)

**Grid Patterns:**
- KPI cards: grid-cols-4 (desktop), grid-cols-2 (tablet), grid-cols-1 (mobile)
- Charts: grid-cols-2 (desktop), grid-cols-1 (mobile)
- Comparison multi-territory: grid-cols-3 (desktop), grid-cols-1 (mobile)

## Component Library

### Navigation
- **Tab Navigation**: Horizontal tabs with active state (cyan underline + bg-cyan-50), hover state (bg-gray-100)
- **Header**: Fixed top, navy background, 64px height, contains logo + title + control panel
- **Control Panel Selectors**: Dropdown style with search capability, white background, border-gray-300

### Data Display
- **KPI Cards**: White cards with shadow, icon top-left (20px), value large (32px bold), label below (14px), trend badge top-right
- **Charts**: White container, title 20px semibold, Chart.js with navy/cyan/orange palette, responsive aspect ratio
- **Data Tables**: Striped rows (alternate bg-gray-50), sortable headers, 14px text, sticky header on scroll

### AI Components
- **Chat Sidebar**: Fixed right, white background, cyan accent header with pulsing icon, message bubbles (user: cyan bg-right, AI: gray bg-left), suggestion chips (cyan outline buttons)
- **AI Analysis Box**: Cyan transparent background, 3px cyan top border, pulsing AI icon, 16px body text, 150-250 words, auto-generated content

### Interactive Elements
- **Primary Buttons**: Orange background, white text, rounded-lg (8px), h-12, hover:bg-orange-600, px-6
- **Secondary Buttons**: White background, navy border, navy text, same dimensions
- **Chips/Tags**: Small rounded-full pills, various colors by status (green: success, yellow: warning, gray: neutral)

### Badges & Indicators
- **Status Badges**: Small (px-2 py-1), rounded, uppercase text (10px), positioned top-right of cards
- **Trend Indicators**: Arrow icons + percentage, color-coded (green up, red down)
- **Loading States**: Skeleton screens matching component structure, subtle gray pulse animation

## Responsive Breakpoints
- **Desktop**: 1280px+ (full layout, sidebar visible)
- **Tablet**: 768px-1279px (sidebar as drawer, 2-column grids)
- **Mobile**: <768px (accordion tabs, stacked layouts, fullscreen chat modal)

## Interaction Patterns
- **Dropdown Selectors**: Click to expand, search functionality, keyboard navigation, max-height with scroll
- **Chart Interactions**: Tooltips on hover, legend toggle, zoom on temporal charts
- **Export Buttons**: Icon + label, positioned top-right of exportable sections
- **Chat Input**: Auto-resize textarea, send on Enter, Shift+Enter for new line

## Animations (Minimal)
- **AI Icon**: Subtle pulse (2s infinite) using opacity 0.7-1.0
- **Loading**: Skeleton pulse (1.5s ease-in-out)
- **Transitions**: 150ms ease for hovers, 300ms ease for modals/drawers
- **Chart Animations**: 750ms entry animations only (no continuous)

## Accessibility
- All interactive elements min 44x44px touch targets
- ARIA labels on all controls, especially selectors and chart elements
- Keyboard navigation: Tab order follows visual flow, Enter/Space activate
- Focus indicators: 2px cyan outline on all interactive elements
- Color contrast: All text meets WCAG AA (4.5:1 minimum)

## Images
**No hero images required** - this is a data dashboard. Visual elements are:
- Logo/branding in header (SVG preferred, max 120px width)
- AI chat icon (pulsing indicator, 24px, cyan accent)
- Territory map in Territorial tab (Leaflet interactive map, full section width)
- Chart icons for empty states (subtle gray, 48px)