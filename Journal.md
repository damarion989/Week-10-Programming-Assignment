## Phase 1
I created a function that returns sensor metadata after a two-second delay. Await lets main receive the completed string before continuing. Without await, the variable holds a Future instead of the metadata. A pending Future represents a result that is not ready yet.

## Phase 2
I created a stream that yields five temperatures and added warnings above 35°C. Yield sends a value while allowing the generator to continue producing more values. Return finishes a Future-returning function with one result.

## Phase 3
I moved the temperature checks into the controller's listener and sent generator readings through controller.add(). A controller lets code manually send events into a stream. Registering the listener first lets it handle events as they arrive instead of leaving them buffered until someone listens.

## Phase 4
I added an error event in place of the fourth reading. The onError callback handles that event, and cancelOnError: false lets the listener process later readings. Try-catch handles synchronous exceptions and failures from awaited operations, while onError handles error events delivered to a stream listener.

## Phase 5
My test results were: [describe the delays, warnings, error handling, and clean shutdown].
Problems I encountered were: [describe any problems, or write none if accurate].
I used ChatGPT for coding guidance. The guidance included registering the listener before sending readings and closing the controller afterward. Changes I made after testing were: [describe your changes, or say none].
