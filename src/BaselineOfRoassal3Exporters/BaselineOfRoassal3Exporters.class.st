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
			spec
				baseline: 'Roassal3'
				with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ].
			spec
				baseline: 'OSSubprocess'
				with: [ spec repository: 'github://pharo-contributions/OSSubprocess/repository' ].
			spec
				baseline: 'Units'
				with: [ spec repository: 'github://zweidenker/Units' ].

			"The packages to use, but not load"
			spec
				package: #'Roassal3-Exporters' with: [ spec requires: self exporterDependencies ];
				package: #'Roassal3-Exporters-Examples';
				package: #'Roassal3-Exporters-Tests';
				package: #'Roassal3-Exporters-Video' with: [spec requires: #('OSSubprocess') ];
				package: #'Roassal3-Exporters-AFrame';
				package: 'Roassal3-Exporters-AFrame-Examples';
				package: #'Roassal3-Exporters-AFrame-Tests'.

			spec
				group: 'Core' with: #(
					'Roassal3-Exporters'
					'Roassal3-Exporters-Examples'
					'Roassal3-Exporters-Tests');
				group: 'Video' with: #(
					'Core'
					'Roassal3-Exporters-Video');
				group: 'AFrame' with: #(
					'Core'
					'Roassal3-Exporters-AFrame'
					'Roassal3-Exporters-AFrame-Tests'
					'Roassal3-Exporters-AFrame-Examples'
				);
				group: 'default' with: #('Core') ]
]

{ #category : #baselines }
BaselineOfRoassal3Exporters >> exporterDependencies [
	^ Smalltalk globals at: #RSCanvas
		ifPresent: [ #('Units') ]
		ifAbsent: [ #('Roassal3' 'Units') ]
]
