# Dashboard de Inteligência Territorial - Tocantins

## Overview

A full-stack web application providing territorial intelligence analysis for public sector managers in Tocantins, Brazil. The dashboard presents data across four key dimensions (Economic, Social, Territorial, and Environmental) with integrated AI-powered analysis to support data-driven decision-making for non-technical users.

The application is **fully functional end-to-end** with real data from PostgreSQL database, operational RAG-based AI chat system using OpenAI, and complete integration between frontend and backend. Currently populated with 21 territorial entities (state of Tocantins + 20 municipalities) with 5 years of historical indicator data across all four dimensions.

**Status**: Production-ready. All 6 tabs functional, AI chat operational with contextual knowledge retrieval, real-time data visualization, and PDF export capabilities.

## User Preferences

Preferred communication style: Simple, everyday language.

## Recent Changes

### November 13, 2025 - System Completion
- **Backend**: Implemented complete RAG pipeline with OpenAI embeddings (text-embedding-3-small) and similarity search
- **API**: Added POST /api/chat endpoint with full integration to RAG system and GPT-4o-mini
- **Frontend**: Connected all 6 tabs (Overview, Economic, Social, Territorial, Environmental, Comparison) to real backend data
- **Data**: Populated database with 21 territories and 5 years of historical indicators across 4 dimensions
- **Knowledge Base**: Generated and stored embeddings for AI contextual analysis
- **Trends**: Implemented real-time trend calculations based on year-over-year data comparisons
- **Testing**: E2E testing confirmed functional UI, data loading, tab navigation, and AI chat interactions

### System Status
- ✅ PostgreSQL database operational with full schema
- ✅ Express API serving all required endpoints
- ✅ RAG system functional with semantic search
- ✅ Frontend displaying real data with automatic updates
- ✅ AI chat providing contextual territorial analysis
- ✅ Export to PDF via browser print dialog
- ✅ Responsive design with mobile support

## System Architecture

### Frontend Architecture

**Framework**: React 18 with TypeScript, styled using Tailwind CSS via shadcn/ui component library ("new-york" style variant).

**Component Structure**:
- Tab-based navigation system with six main views (Overview, Economic, Social, Territorial, Environmental, Comparison)
- Persistent chat sidebar (300px fixed width on desktop, fullscreen modal on mobile) for AI interaction
- Reusable components: KPI cards, data tables, AI analysis boxes
- Responsive layout with mobile-first breakpoints (768px threshold)

**State Management**: TanStack Query (React Query) for server state management with infinite stale time and disabled refetching strategies.

**Design System**: 
- Navy blue primary background (#1e3a8a) with cyan accents (#06b6d4) for AI features
- Inter font family from Google Fonts
- Custom CSS variables for theming with light mode implementation
- Utility-first approach prioritizing data density and accessibility

### Backend Architecture

**Server Framework**: Express.js with TypeScript running on Node.js, using ES modules.

**API Design**: RESTful endpoints under `/api` prefix:
- `/api/territories` - CRUD operations for territorial entities
- `/api/territories/:id/indicators/{economic|social|territorial|environmental}` - Dimension-specific indicator retrieval
- Zod schema validation on all POST endpoints

**Data Layer**: Storage abstraction pattern (`IStorage` interface) separating business logic from database operations, implemented via `storage.ts` with methods for territories and all four indicator types.

**AI Integration**: 
- RAG (Retrieval-Augmented Generation) system using OpenAI API
- Vector similarity search for contextual knowledge retrieval
- Chat completion with system prompts tailored to territorial analysis
- Embedding generation for knowledge base indexing

### Database Architecture

**Database**: PostgreSQL accessed via Neon serverless driver with WebSocket support.

**ORM**: Drizzle ORM with schema-first approach defined in `shared/schema.ts`.

**Schema Design**:
- `territories` table: Hierarchical structure with self-referencing parent relationships, JSONB metadata storage
- Four indicator tables (`economic_indicators`, `social_indicators`, `territorial_indicators`, `environmental_indicators`): Each linked to territories via foreign keys with yearly time-series data
- `knowledge_base` table: Stores RAG embeddings as JSON strings with dimension categorization

**Extensions Required**: 
- PostGIS for geospatial data (referenced but not yet implemented)
- pgvector for vector embeddings (referenced in config)

**Migration Strategy**: Drizzle Kit with migrations output to `/migrations` directory, push command for schema deployment.

### Development Environment

**Build System**: Vite for frontend bundling with esbuild for backend compilation to ESM format.

**Development Features**:
- Replit-specific plugins for runtime error overlay, cartographer, and dev banner
- Path aliases: `@/` for client source, `@shared/` for shared types, `@assets/` for attached assets
- Hot module replacement in development mode
- Logging middleware for API request tracking

**Type Safety**: Shared TypeScript types between frontend and backend via `@shared/schema`, using Drizzle-Zod for runtime validation from database schema.

## External Dependencies

### Third-Party Services

**OpenAI API**: 
- `text-embedding-3-small` model for embedding generation
- `gpt-4o-mini` model for chat completions
- Requires `OPENAI_API_KEY` environment variable

### Database Service

**Neon Database**: 
- Serverless PostgreSQL provider
- WebSocket-based connection pooling
- Requires `DATABASE_URL` environment variable
- Configured for PostgreSQL 14+ compatibility

### UI Component Library

**shadcn/ui**: Comprehensive component library built on Radix UI primitives including:
- Form controls (Select, Input, Checkbox, Radio, Switch)
- Layout components (Card, Dialog, Tabs, Accordion)
- Feedback components (Toast, Alert, Progress)
- Data display (Table, Badge, Avatar)
- Navigation (Dropdown Menu, Command, Context Menu)

### Supporting Libraries

**Frontend**:
- `@tanstack/react-query` v5 for data fetching and caching
- `react-hook-form` with Zod resolvers for form validation
- `date-fns` for date manipulation
- `embla-carousel-react` for carousel functionality
- `cmdk` for command palette patterns

**Backend**:
- `connect-pg-simple` for PostgreSQL session storage
- `drizzle-orm` and `drizzle-kit` for database operations
- `zod` for schema validation
- `nanoid` for unique ID generation

**Build Tools**:
- `tsx` for TypeScript execution in development
- `esbuild` for production backend bundling
- `tailwindcss` and `autoprefixer` for styling