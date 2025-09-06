import React from 'react';
import FlipDigit from './FlipDigit';

interface FlipClockProps {
  days: number;
  hours: number;
  minutes: number;
  seconds: number;
}

const FlipClock: React.FC<FlipClockProps> = ({ days, hours, minutes, seconds }) => {
  return (
    <div className="glass-morphism rounded-2xl p-6 md:p-8 shadow-2xl animate-glow">
      <div className="flex justify-center items-end space-x-6 md:space-x-10">
        <FlipDigit value={days} label="Days" />
        <div className="text-white text-2xl md:text-3xl font-bold pb-6 md:pb-8" style={{ textShadow: '2px 2px 4px rgba(0, 0, 0, 0.8)' }}></div>
        <FlipDigit value={hours} label="Hours" />
        <div className="text-white text-2xl md:text-3xl font-bold pb-6 md:pb-8" style={{ textShadow: '2px 2px 4px rgba(0, 0, 0, 0.8)' }}></div>
        <FlipDigit value={minutes} label="Minutes" />
        <div className="text-white text-2xl md:text-3xl font-bold pb-6 md:pb-8" style={{ textShadow: '2px 2px 4px rgba(0, 0, 0, 0.8)' }}></div>
        <FlipDigit value={seconds} label="Seconds" />
      </div>
    </div>
  );
};

export default FlipClock;
