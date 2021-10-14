"
This new exporter, is similar to RTSVGExporter from roassal2 a pure smalltalk object that allow to the user to convert the roassal3 shapes into an svg shape
"
Class {
	#name : #RSSVG2Exporter,
	#superclass : #RSRoassalExporter,
	#instVars : [
		'stream'
	],
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #public }
RSSVG2Exporter >> exportToFile: file [
	| morph |
	morph := self morph.
	file writeStreamDo: [ :aStream | 
		self cameraSetter set: [ 
			canvas := morph roassalCanvas.
			morph drawShapes.
			stream := aStream.
			canvas accept: self.
		].
	].
	
]

{ #category : #accessing }
RSSVG2Exporter >> extension [
	^ 'svg'
]

{ #category : #visiting }
RSSVG2Exporter >> visitCanvas: aRSCanvas [ 
	self write: '<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500pt" height="500pt" viewBox="0 0 500 500" version="1.1">
'.
	aRSCanvas shapes do: [ :shape | shape accept: self ].
	self write: '</svg>'.
]

{ #category : #visiting }
RSSVG2Exporter >> visitLabel: aRSLabel [ 
	self write: '<text x="0" y="15" fill="black">Hello world</text>'
]

{ #category : #visiting }
RSSVG2Exporter >> write: aString [
	stream nextPutAll: (aString copyReplaceAll: String cr with: String crlf)
]
