import { FlipClock } from './components/FlipClock';
import { LockIcon } from './components/LockAnimation';
import { RevealContent } from './components/RevealContent';
import { useCountdown } from './hooks/useCountdown';

function App() {
  // Target date: September 10, 2025 at 8:00 PM EST
  const targetDate = new Date('2025-09-10T20:00:00-04:00');
  const { days, hours, minutes, seconds, isComplete } = useCountdown(targetDate);
  
  const anniversaryLink = 'https://bit.ly/mbanniversary';

  return (
    <div className="min-h-screen bg-cover bg-center bg-no-repeat relative overflow-hidden"
         style={{
           backgroundImage: `linear-gradient(rgba(139, 92, 246, 0.3), rgba(99, 102, 241, 0.3)), url('/background.png')`
         }}>
      
      {/* Background overlay for better readability */}
      <div className="absolute inset-0 bg-black bg-opacity-20"></div>
      
      {/* Main content */}
      <div className="relative z-10 min-h-screen flex flex-col items-center justify-between p-4">
        
        {/* Top spacer for vertical centering */}
        <div></div>
        
        {/* Center content */}
        <div className="flex flex-col items-center space-y-8">
          {/* Title */}
          <div className="text-center mb-8">
            <h1 className="text-4xl md:text-6xl font-bold text-white mb-4" style={{ textShadow: '2px 2px 8px rgba(0, 0, 0, 0.9)' }}>
              Our Anniversary
            </h1>
            <p className="text-xl md:text-2xl text-white" style={{ textShadow: '1px 1px 4px rgba(0, 0, 0, 0.8)' }}>
              {isComplete ? 'The moment has arrived!' : 'Counting down to something special...'}
            </p>
          </div>

          {/* Countdown or Reveal Content */}
          {!isComplete ? (
            <>
              <FlipClock 
                days={days}
                hours={hours}
                minutes={minutes}
                seconds={seconds}
              />
              
              {/* Lock Icon */}
              <div className="mt-8">
                <LockIcon isUnlocked={false} />
              </div>
              
              <p className="text-white text-center max-w-md text-lg" style={{ textShadow: '1px 1px 3px rgba(0, 0, 0, 0.8)' }}>
                Something magical is waiting for you when this countdown reaches zero...
              </p>
            </>
          ) : (
            <>
              {/* Unlocked state */}
              <div className="mb-6">
                <LockIcon isUnlocked={true} />
              </div>
              
              <RevealContent link={anniversaryLink} />
            </>
          )}
        </div>
        
        {/* Footer */}
        <div className="text-center py-4">
          <p className="text-white text-sm" style={{ textShadow: '1px 1px 2px rgba(0, 0, 0, 0.8)' }}>
            Made with 💜 for our special day
          </p>
        </div>
      </div>
    </div>
  );
}

export default App;
