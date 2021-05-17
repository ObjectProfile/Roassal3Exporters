"
TODO
"
Class {
	#name : #RSPNGExporter,
	#superclass : #RSRoassalExporter,
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #public }
RSPNGExporter >> exportToFile: file [
	| morph |
	morph := self morph.
	self cameraSetter set: [
		| surface |
		surface := AthensCairoSurface extent: morph extent asIntegerPoint.
		surface drawDuring: [ :can | morph fullDrawOnAthensCanvas: can ].
		surface writeToPng: file pathString.
		surface flush.
		
		"The following may fail when the VM is run in the headless mode"
		[ surface finish ] on: Error do: [ :ex  | "Do nothing" ]. 
		 ]
]

{ #category : #accessing }
RSPNGExporter >> extension [
	^ 'png'
]
