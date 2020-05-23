"
TODO
"
Class {
	#name : #RSSVGExporter,
	#superclass : #RSCairoExporter,
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #public }
RSSVGExporter >> cairoSurfaceClass [ 
	^ AthensCairoSVGSurface
]

{ #category : #accessing }
RSSVGExporter >> extension [
	^ 'svg'
]
