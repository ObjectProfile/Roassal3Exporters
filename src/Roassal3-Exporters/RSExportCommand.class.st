"
Used to export a view with the canvas with the inspector
"
Class {
	#name : #RSExportCommand,
	#superclass : #CmCommand,
	#category : #'Roassal3-Exporters-Inspector'
}

{ #category : #initialization }
RSExportCommand class >> defaultIconName [
	^ #remote
]

{ #category : #initialization }
RSExportCommand class >> forSpec [ 
	^self forSpecWithIconNamed: self defaultIconName
]

{ #category : #executing }
RSExportCommand >> execute [
	| name |
	name := self exporterClass new
		canvas: context model inspectedObject;
		export.
	self inform: 'Created ',name.
]

{ #category : #accessing }
RSExportCommand >> exporterClass [
	^ self subclassResponsibility
]
