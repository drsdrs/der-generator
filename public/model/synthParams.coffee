define [], ()->

  synthParams = {}

  synthParams.BasicSynth =
  [
    [
      [
        label: "OSC-A Volume"
        param: "setVolA"
        colorG: "synthParamGroup-A"
        type: "slider"
        range:[0, 0.5]
        step:0.01
        value: 0.05
      ]
      [
        label: "OSC-A Waveshape"
        param: "setWaveOscA"
        colorG: "synthParamGroup-A"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "invSawtooth"]
        value: "sine"
      ]
    ]
    [
      [
        label: "OSC-B Volume"
        param: "setVolB"
        colorG: "synthParamGroup-C"
        type: "slider"
        range:[0, 0.5]
        step:0.01
        value: 0.15
      ]
      [
        label: "OSC-B Waveshape"
        param: "setWaveOscB"
        colorG: "synthParamGroup-C"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "invSawtooth"]
        value: "sawtooth"
      ]
    ]
    [
      [
        label: "OSC Frequency"
        param: "setFreq"
        colorG: "synthParamGroup-A"
        type: "slider"
        range:[0.01, 880]
        step:0.01
        value: 88
      ]
    ]
  ]

  synthParams.Synth1 =
  [
    [
      [
        label: "OSC Frequency"
        param: "setFreq"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0.01, 880]
        step: 0.01
        value: 110

      ]
      [
        label: "OSC Detune"
        param: "setDetune"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0.01, 12]
        step: 0.01
        value: 0.4
      ]
      [
        label: "OSC Volume"
        param: "setVol"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 0.04
      ]
    ]
    [
      [
        label: "OSC-Pitch Frequency"
        param: "setFreqOscPitch"
        colorG: "synthParamGroup-C"
        type: "slider"
        range:[0.2, 12]
        step:0.2
        value: 0.5
      ]
      [
        label: "OSC-Pitch Mix"
        param: "setMixPitch"
        colorG: "synthParamGroup-C"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 0.1
      ]
      [
        label: "OSC-Pitch Waveshape"
        param: "setWaveOscPitch"
        colorG: "synthParamGroup-C"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "invSawtooth"]
        value: "sine"
      ]
    ]
    [
      [
        label: "OSC-Amp Frequency"
        param: "setFreqOscAmp"
        colorG: "synthParamGroup-B"
        type: "slider"
        range:[0.2, 12]
        step:0.2
        value: 2
      ]
      [
        label: "OSC-Amp Mix"
        param: "setMixAmp"
        colorG: "synthParamGroup-B"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 1
      ]
      [
        label: "OSC-Amp Waveshape"
        param: "setWaveOscAmp"
        colorG: "synthParamGroup-B"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "invSawtooth"]
        value: "triangle"
      ]
    ]
    [
      [
        label: "OSC-Phase Frequency"
        param: "setFreqOscPhase"
        colorG: "synthParamGroup-A"
        type: "slider"
        range:[0.01, 12]
        step:0.01
        value: 0.2
      ]
      [
        label: "OSC-Phase Mix"
        param: "setMixPhase"
        colorG: "synthParamGroup-A"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 0.7
      ]
      [
        label: "OSC-Phase Waveshape"
        param: "setWaveOscPhase"
        colorG: "synthParamGroup-A"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "invSawtooth"]
        value: "sawtooth"
      ]
    ]
    [
      [
        label: "OSC-A Volume"
        param: "setVolA"
        colorG: "synthParamGroup-D"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 0.6
      ]
      [
        label: "OSC-A Waveshape"
        param: "setWaveOscA"
        colorG: "synthParamGroup-D"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "invSawtooth"]
        value: "sawtooth"
      ]
    ]
    [
      [
        label: "OSC-B Volume"
        param: "setVolB"
        colorG: "synthParamGroup-E"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 1
      ]
      [
        label: "OSC-B Waveshape"
        param: "setWaveOscB"
        colorG: "synthParamGroup-E"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "invSawtooth"]
        value: "triangle"
      ]
    ]
    [
      [
        label: "OSC-C Volume"
        param: "setVolC"
        colorG: "synthParamGroup-F"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 1
      ]
      [
        label: "OSC-C Waveshape"
        param: "setWaveOscC"
        colorG: "synthParamGroup-F"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "invSawtooth"]
        value: "sine"
      ]
    ]
  ]

  return synthParams