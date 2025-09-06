# Project Brief - Anniversary Countdown App

## Overview
A romantic single-page React application featuring a countdown timer to Matt's anniversary (September 10, 2024 at 8:00 PM EST), with a lock/unlock mechanism that reveals a special surprise link when the countdown completes.

## Core Requirements
- **Framework**: React SPA with TypeScript
- **Build Tool**: Vite for fast development and building
- **Styling**: Tailwind CSS with custom purple/indigo color scheme
- **Background**: Custom background.png image with overlay
- **Countdown Target**: September 10, 2024, 8:00 PM EST
- **Surprise Link**: https://bit.ly/mbanniversary (revealed when countdown completes)

## Key Features
1. **Flip Clock Countdown**: Animated countdown showing Days:Hours:Minutes:Seconds
2. **Lock Animation**: Interactive lock icon that unlocks when countdown completes
3. **Surprise Reveal**: Shows anniversary message and link after countdown
4. **Responsive Design**: Works on mobile and desktop
5. **Custom Branding**: Purple heart favicon and romantic styling

## Design Theme
- **Color Scheme**: Purple (#8B5CF6) and Indigo (#6366F1) gradients
- **Typography**: White text with black drop shadows for readability
- **Visual Effects**: Glass morphism, glowing animations, smooth transitions
- **Background**: Custom image with purple/indigo overlay

## Deployment
- **Containerization**: Docker with nginx serving static build
- **Port**: Accessible on localhost:3000
- **Production Ready**: Multi-stage Docker build with optimizations

## Constraints
- Single page application (no routing)
- Must work without JavaScript dependencies in production
- Optimized for romantic/anniversary theme
- Mobile-first responsive design
