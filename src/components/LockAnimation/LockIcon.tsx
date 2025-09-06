import React, { useState, useEffect } from 'react';
import { Lock, LockOpen } from 'lucide-react';

interface LockIconProps {
  isUnlocked: boolean;
}

const LockIcon: React.FC<LockIconProps> = ({ isUnlocked }) => {
  const [isAnimating, setIsAnimating] = useState(false);

  useEffect(() => {
    if (isUnlocked) {
      setIsAnimating(true);
      const timer = setTimeout(() => setIsAnimating(false), 800);
      return () => clearTimeout(timer);
    }
  }, [isUnlocked]);

  if (isUnlocked) {
    return (
      <div className={`transition-all duration-500 ${isAnimating ? 'animate-unlock' : ''}`}>
        <LockOpen 
          size={64} 
          className="text-yellow-400 drop-shadow-lg animate-glow" 
          style={{
            filter: 'drop-shadow(0 0 20px rgba(251, 191, 36, 0.8))'
          }}
        />
      </div>
    );
  }

  return (
    <div className="transition-all duration-300">
      <Lock 
        size={64} 
        className="text-primary-300 drop-shadow-lg hover:animate-shake cursor-pointer" 
      />
    </div>
  );
};

export default LockIcon;
