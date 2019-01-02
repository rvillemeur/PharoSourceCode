Class {
	#name : #GAExample,
	#superclass : #Object,
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #'as yet unclassified' }
GAExample >> tsp [

"points := { 0@0 . 0@100 . 100@0 . 100@100 }."

| points tmp g result v elements |
points := ((Array new: 20) at: 1 put: ((100@160)); at: 2 put: ((20@40)); at: 3 put: ((60@20)); at: 4 put: ((180@100)); at: 5 put: ((200@40)); at: 6 put: ((60@200)); at: 7 put: ((80@180)); at: 8 put: ((40@120)); at: 9 put: ((140@180)); at: 10 put: ((140@140)); at: 11 put: ((20@160)); at: 12 put: ((200@160)); at: 13 put: ((180@60)); at: 14 put: ((100@120)); at: 15 put: ((120@80)); at: 16 put: ((100@40)); at: 17 put: ((20@20)); at: 18 put: ((60@80)); at: 19 put: ((180@200)); at: 20 put: ((160@20)); yourself).

tmp := nil.

    g := GAEngine new.
	g endForMaxNumberOfGeneration: 100.
	g mutationRate: 0.15.
    g populationSize: 60.
    g numberOfGenes: points size.
	g crossoverOperator:  GAOrderedCrossoverOperation new.
	g beforeCreatingInitialIndividual: [ :rand | tmp := points copy shuffleBy: rand ].
		g mutationOperator: GASwapMutationOperation new.
    g createGeneBlock: [ :rand :index :ind | tmp at: index ].

	g minimizeComparator.
    g fitnessBlock: [ :genes |
		| distance d |
		distance := 0.
		2 to: genes size do: [ :pointIndex |
			d := (genes at: pointIndex) dist: (genes at: pointIndex - 1).
			distance := distance + (d ) ].
		distance ].
    
    g run.


result := g result.
v := RTView new.
elements := RTEllipse new size: 10; color: Color red trans; elementsOn: result.
elements @ RTPopup.
v addAll: elements.
elements do: [ :e | e translateTo: e model ].
2 to: result size do: [ :index |
	| l |
	l := RTArrowedLine new color: Color blue; headOffset: 0.8.
	v add: (l edgeFrom: (v elementFromModel: (result at: index - 1)) to: (v elementFromModel: (result at: index))) ].
v
]