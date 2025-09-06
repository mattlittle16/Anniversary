import React, { useState, useEffect } from 'react';

interface FlipDigitProps {
  value: number;
  label: string;
}

const FlipDigit: React.FC<FlipDigitProps> = ({ value, label }) => {
  const [displayValue, setDisplayValue] = useState(value);
  const [isFlipping, setIsFlipping] = useState(false);

  useEffect(() => {
    if (value !== displayValue) {
      setIsFlipping(true);
      setTimeout(() => {
        setDisplayValue(value);
        setIsFlipping(false);
      }, 300);
    }
  }, [value, displayValue]);

  const formatValue = (num: number) => num.toString().padStart(2, '0');

  return (
    <div className="flex flex-col items-center space-y-3 min-w-[7rem] md:min-w-[7.5rem]">
      <div className="w-16 h-20 md:w-20 md:h-24 glass-morphism bg-gradient-to-br from-primary-600 to-secondary-600 rounded-lg shadow-lg flex items-center justify-center transition-all duration-300">
        <span 
          className={`text-white font-bold text-2xl md:text-3xl transition-all duration-300 ${isFlipping ? 'scale-110' : 'scale-100'}`}
          style={{ textShadow: '2px 2px 4px rgba(0, 0, 0, 0.8)', color: 'white' }}
        >
          {formatValue(isFlipping ? value : displayValue)}
        </span>
      </div>
      <span className="text-white text-xs md:text-sm font-semibold uppercase tracking-wider text-center w-full whitespace-nowrap" style={{ textShadow: '1px 1px 3px rgba(0, 0, 0, 0.9)' }}>
        {label}
      </span>
    </div>
  );
};

export default FlipDigit;
