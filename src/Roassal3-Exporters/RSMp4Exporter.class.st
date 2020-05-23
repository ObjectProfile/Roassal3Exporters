"
TODO
"
Class {
	#name : #RSMp4Exporter,
	#superclass : #RSRoassalExporter,
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #public }
RSMp4Exporter >> exportToFile: file [
	"TODO"
	self subclassResponsibility
]

{ #category : #accessing }
RSMp4Exporter >> extension [
	^ 'mp4'
]
