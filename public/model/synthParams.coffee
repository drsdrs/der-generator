define [], () ->
  synthParams=

    ADSREnvelope:
      inputs:
        triggerGate: "0|1"
        attack: "0-1"
      outputs:
        value: "0-1"

    Oscillator:
      inputs:
        freq: "0-20000"
        pulseWidth: "0-1"
      outputs:
        value: "0-1"

    Noise:
      inputs: null
      outputs:
        value: "0-1"

    Amp:
      inputs:
        amp: "0-1"
      outputs:
        value: "0-1"

    Delay:
      inputs:
        time: "0-1"
        feedback: "0-1"
      outputs:
        value: "0-1"

    Chorus:
      inputs:
        time: "0-1"
        depth: "0-1"
        freq: "0-1"
      outputs:
        value: "0-1"

    Keyboard:
      inputs: null
      outputs:
        value: "0-1"