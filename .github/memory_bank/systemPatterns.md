# System Patterns & Architecture

## Component Architecture
```
App
├── FlipClock (countdown display)
│   ├── FlipDigit (individual time units)
│   └── index.ts (exports)
├── LockAnimation
│   ├── LockIcon (lock/unlock states)
│   └── index.ts (exports)
├── RevealContent (post-countdown content)
│   └── index.ts (exports)
└── hooks/
    └── useCountdown (countdown logic)
```

## Key Design Patterns

### 1. Component Composition
- **FlipClock**: Orchestrates multiple FlipDigit components
- **App**: Coordinates all major sections based on countdown state
- **Separation of Concerns**: Each component has single responsibility

### 2. Custom Hook Pattern
- **useCountdown**: Encapsulates countdown logic and state management
- **Returns**: `{ days, hours, minutes, seconds, isComplete }`
- **Updates**: Every second via setInterval

### 3. State-Driven UI
- **Primary State**: `isComplete` boolean drives entire UI flow
- **Conditional Rendering**: Shows countdown OR reveal content
- **Animation States**: Components manage their own animation states

### 4. Layout Patterns
- **Flexbox Layout**: Consistent use of flex for alignment
- **Responsive Design**: Mobile-first with md: breakpoints
- **Glass Morphism**: Consistent styling across interactive elements

## Data Flow
```
useCountdown → App → FlipClock → FlipDigit
                  ↓
            LockIcon + RevealContent
```

## Animation Strategy
- **Flip Effect**: Removed complex absolute positioning for simple scale transforms
- **Lock Animation**: Smooth transitions with CSS transforms
- **Text Effects**: Drop shadows for readability across backgrounds

## Styling Architecture
- **Tailwind CSS**: Utility-first approach
- **Custom Colors**: Extended palette for purple/indigo theme
- **Responsive Classes**: Mobile-first breakpoint strategy
- **Inline Styles**: For dynamic properties (textShadow, background images)

## Performance Considerations
- **Single Page**: No routing overhead
- **Optimized Images**: Background image optimization
- **Docker Build**: Multi-stage builds for production
- **Static Serving**: nginx for optimal performance
