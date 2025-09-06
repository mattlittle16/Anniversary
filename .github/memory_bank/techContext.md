# Technical Context

## Tech Stack
- **Frontend**: React 19.1.1 with TypeScript
- **Build Tool**: Vite 7.1.2 (fast development and building)
- **Styling**: Tailwind CSS 4.1.13 with custom configuration
- **Icons**: Lucide React 0.542.0 (for lock and heart icons)
- **Deployment**: Docker with nginx alpine

## Development Environment
- **Node.js**: 18+ (alpine in Docker)
- **Package Manager**: npm
- **Development Server**: Vite dev server (HMR enabled)
- **TypeScript**: ~5.8.3 with strict configuration

## Build Configuration

### Vite Setup
- **Plugin**: @vitejs/plugin-react for React support
- **Build Target**: ES modules for modern browsers
- **Asset Handling**: Public folder for static assets (background.png, favicon)

### Tailwind Configuration
```javascript
// Key customizations:
- Custom purple/indigo color palette
- Animation keyframes for flip, unlock, glow effects
- Glass morphism utilities
- Responsive breakpoints
```

### PostCSS Configuration
- **@tailwindcss/postcss**: Latest plugin for Tailwind v4
- **Autoprefixer**: Cross-browser CSS compatibility

## Docker Strategy
- **Multi-stage Build**: Node.js build → nginx serve
- **Base Images**: node:18-alpine, nginx:alpine
- **Port**: Container runs on port 80, mapped to 3000
- **Health Checks**: Built-in endpoint monitoring

## Key Dependencies
```json
{
  "lucide-react": "Lock/heart icons",
  "@tailwindcss/postcss": "Tailwind v4 compatibility",
  "typescript": "Type safety and developer experience"
}
```

## Performance Optimizations
- **Static Assets**: 1-year cache headers for images/fonts
- **Gzip Compression**: nginx-level compression
- **Bundle Optimization**: Vite's built-in tree shaking
- **Image Optimization**: Background image served efficiently

## Browser Support
- **Target**: Modern browsers (ES2020+)
- **Mobile**: iOS Safari 14+, Chrome 88+
- **Desktop**: Chrome 88+, Firefox 85+, Safari 14+

## Development Constraints
- **No Backend**: Pure frontend application
- **Static Deployment**: Must work as static files
- **Responsive**: Mobile-first design requirements
- **Accessibility**: White text with drop shadows for readability
