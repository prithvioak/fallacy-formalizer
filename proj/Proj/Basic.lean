namespace fallacyFormalization

-- #eval 5 + 5 + 5

set_option linter.deprecated false

structure Argument :=
  (premises : List Prop)
  (conclusion : Prop)

def premises_true (arg : Argument) : Prop :=
  ∀ p ∈ arg.premises, p

-- def premises_true (arg : Argument) : Prop :=
--   List.foldl And True arg.premises
-- Decide which definition to use

def Argument.valid (arg : Argument) : Prop :=
  premises_true arg → arg.conclusion

def Argument.invalid (arg : Argument) : Prop :=
  ¬ Argument.valid arg

def Argument.sound (arg : Argument) : Prop :=
  Argument.valid arg ∧ premises_true arg
-- CHECK THIS ^^^

def Argument.unsound (arg : Argument) : Prop :=
  ¬ Argument.sound arg

def Argument.complete (arg : Argument) : Prop :=
  arg.conclusion → Argument.valid arg

#eval 3 + 3
-- AND THIS ^^^

-- def Argument.incomplete (arg : Argument) : Prop :=
--   ¬ Argument.complete arg

-- def Argument.acceptable (arg : Argument) : Prop :=
--   Argument.valid arg ∧ Argument.sound arg

-- MOCK TYPE SYSTEM FOR THE FOLLOWING SENTENCES:
-- "The cow likes the dog."
-- "The dog needs the cow."
-- "The cow needs the cow."
-- "If something needs the cow, then it likes the cow."
-- Question: "Does the cow like the cow?"


-- opaque Animal : Type
inductive Animal
  | Cow
  | Dog
  | Cat
  | Horse

opaque Likes : Animal → Animal → Prop
opaque Needs : Animal → Animal → Prop
opaque Big : Animal → Prop

-- Axioms
axiom T1 : Likes Animal.Cow Animal.Dog
axiom T2 : Needs Animal.Dog Animal.Cow
axiom T3 : Needs Animal.Cow Animal.Cow
axiom R1 : ∀ x, Needs x Animal.Cow → Likes x Animal.Cow

-- Answering question
theorem Q1 : Likes Animal.Cow Animal.Cow := by
  apply R1
  apply T3

theorem Q2 : Likes Animal.Dog Animal.Cow := by
  apply R1
  apply T2



-- Now the real stuff: Fallacies!

def is_strawman (arg1 arg2 : Argument) : Prop :=
  ∃ p ∈ arg2.premises, ¬ p ∈ arg1.premises -- this def feels wrong

-- red herring

-- circular reasoning

-- ad hominem??

-- appeal to authority

-- appeal to ignorance

-- appeal to popularity

-- Hasty generalization

-- False dilemma

-- Slippery slope

-- Begging the question -- show that this is equivalent to circular reasoning

-- causal fallacy (Whenever I wear my lucky jersey, my team loses. So it must actually be my unlucky jersey!)

-- fallacy of composition (Every part of the boat is light, so the boat is light.)

-- fallacy of division (The boat is light, so every part of the boat is light.)

end fallacyFormalization


-- #eval Lean.versionString
