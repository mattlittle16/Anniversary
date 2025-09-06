import React from 'react';
import { ExternalLink, Heart } from 'lucide-react';

interface RevealContentProps {
  link: string;
}

const RevealContent: React.FC<RevealContentProps> = ({ link }) => {
  return (
    <div className="animate-fade-in glass-morphism rounded-2xl p-8 md:p-12 shadow-2xl max-w-md mx-auto">
      <div className="text-center space-y-6">
        <div className="flex justify-center">
          <Heart 
            size={48} 
            className="text-red-400 animate-pulse" 
            fill="currentColor"
          />
        </div>
        
        <h2 className="text-2xl md:text-3xl font-bold text-white mb-4" style={{ textShadow: '2px 2px 6px rgba(0, 0, 0, 0.9)' }}>
          Happy Anniversary! 💕
        </h2>
        
        <p className="text-white text-lg mb-6" style={{ textShadow: '1px 1px 3px rgba(0, 0, 0, 0.8)' }}>
          The countdown is complete! Here's your special surprise...
        </p>
        
        <a
          href={link}
          target="_blank"
          rel="noopener noreferrer"
          className="inline-flex items-center space-x-2 bg-gradient-to-r from-primary-600 to-secondary-600 hover:from-primary-700 hover:to-secondary-700 text-white font-semibold py-4 px-8 rounded-full transition-all duration-300 transform hover:scale-105 shadow-lg"
        >
          <span>Open Your Gift</span>
          <ExternalLink size={20} />
        </a>
        
        <div className="mt-6 text-white text-sm" style={{ textShadow: '1px 1px 2px rgba(0, 0, 0, 0.8)' }}>
          Click the link above to see your anniversary surprise! 🎁
        </div>
      </div>
    </div>
  );
};

export default RevealContent;
