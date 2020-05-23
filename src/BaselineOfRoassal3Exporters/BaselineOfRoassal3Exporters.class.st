"
I load roassal3 and Roassal3-Exporters
"
Class {
	#name : #BaselineOfRoassal3Exporters,
	#superclass : #BaselineOf,
	#category : #BaselineOfRoassal3Exporters
}

{ #category : #baselines }
BaselineOfRoassal3Exporters >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"our dependencies"
			"https://github.com/ObjectProfile/Roassal3Exporters"
			spec baseline: 'Roassal3' with: [ spec repository: 'github://ObjectProfile/Roassal3' ].
			
			"The packages to use, but not load"
			spec
				package: #'Roassal3-Exporters' with: [ spec requires: #('Roassal3') ].

			spec
				group: 'default' with: #('Roassal3-Exporters') ].

		
	







]
