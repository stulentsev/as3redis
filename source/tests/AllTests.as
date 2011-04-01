/**
 * Copyright (c) 2011 Sergey Tulentsev
 * The code is provided as-is, no warranties and all that stuff.
 */


package tests {
import flash.events.Event;

public class AllTests extends TestSuiteBase {
    private var _suites : Array = [];

    private var _completedCount : uint = 0;
    private var _isRunning : Boolean = false;

    public function AllTests(logger : Function) {
        super(logger);

        _suites.push(new Hashes(logger));
    }

    override public function runTests() : void {
        if(_isRunning) return;

        _isRunning = true;
        _completedCount = 0;

        for each(var s : TestSuiteBase in _suites) {
            s.addEventListener(Event.COMPLETE, onSuiteComplete)
            s.runTests();
        }
    }

    private function onSuiteComplete(evt : Event) : void {
        _completedCount += 1;
        logger(_completedCount + ' / ' + _suites.length);

        if(_completedCount == _suites.length) {
            _isRunning = false;
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }
}
}
