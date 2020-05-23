"
TODO
"
Class {
	#name : #RSPDFExporter,
	#superclass : #RSCairoExporter,
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #public }
RSPDFExporter >> cairoSurfaceClass [ 
	^ AthensCairoPDFSurface
]

{ #category : #accessing }
RSPDFExporter >> extension [
	^ 'pdf'
]
