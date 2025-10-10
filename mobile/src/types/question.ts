export type Category = 'pre-flop' | 'post-flop' | 'turn' | 'river' | 'special';
export type Difficulty = 'beginner' | 'intermediate' | 'advanced';
export type Position = 'Button' | 'Cutoff' | 'Middle' | 'Early' | 'Small Blind' | 'Big Blind';

export interface Scenario {
  yourHand: string;
  position: Position;
  stackSize: number;
  blinds: string;
  potSize: number;
  actionSoFar: string;
  communityCards?: string;
  playersRemaining: number;
  effectiveStacks: number;
}

export interface Choice {
  id: string;
  action: string;
}

export interface Question {
  id: string;
  category: Category;
  difficulty: Difficulty;
  scenario: Scenario;
  question_text: string;
  choices: Choice[];
  correct_answer: string;
  explanation: string;
  key_concepts: string[];
  created_at?: string;
  updated_at?: string;
}