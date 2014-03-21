define [], ()->

  synthParams = {}

  synthParams.BasicSynth =
  [
    [
      [
        label: "OSC Detune"
        param: "setDetune"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0.01, 44]
        step:0.2
        value: 10
      ]
      [
        label: "OSC Freq"
        param: "setFreq"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0.01, 440]
        step:0.2
        value: 10
      ]
      [
        label: "OSC Volume"
        param: "setVol"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 0.01
      ]
    ]
    [
      [
        label: "OSC-Amp Frequency"
        param: "setFreqOscAmp"
        colorG: "synthParamGroup-B"
        type: "slider"
        range:[0.2, 440]
        step:0.2
        value: 10
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
    ]
    [
      [
        label: "OSC-Phase Frequency"
        param: "setFreqOscPhase"
        colorG: "synthParamGroup-A"
        type: "slider"
        range:[0.01, 440]
        step:0.01
        value: 1
      ]
      [
        label: "OSC-Phase Mix"
        param: "setMixPhase"
        colorG: "synthParamGroup-A"
        type: "slider"
        range:[0, 8]
        step:0.01
        value: 1
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
        value: 1
      ]
      [
        label: "OSC-A Waveshape"
        param: "setWaveOscA"
        colorG: "synthParamGroup-D"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "invSawtooth"]
        value: "pulse"
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
        range:[0.01, 440]
        step:0.01
        value: 220

      ]
      [
        label: "OSC Detune"
        param: "setDetune"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0.01, 44]
        step:0.2
        value: 10
      ]
      [
        label: "OSC Volume"
        param: "setVol"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 0.08
      ]
    ]
    [
      [
        label: "OSC-Pitch Frequency"
        param: "setFreqOscPitch"
        colorG: "synthParamGroup-C"
        type: "slider"
        range:[0.2, 44]
        step:0.2
        value: 4
      ]
      [
        label: "OSC-Pitch Mix"
        param: "setMixPitch"
        colorG: "synthParamGroup-C"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 1
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
        range:[0.2, 44]
        step:0.2
        value: 2
      ]
      [
        label: "OSC-Amp Mix"
        param: "setWaveOscAmp"
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
        range:[0.01, 44]
        step:0.01
        value: 1
      ]
      [
        label: "OSC-Phase Mix"
        param: "setMixPhase"
        colorG: "synthParamGroup-A"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 1
      ]
      [
        label: "OSC-Phase Waveshape"
        param: "setWaveOscPhase"
        colorG: "synthParamGroup-A"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "invSawtooth"]
        value: "triangle"
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
        value: 1
      ]
      [
        label: "OSC-A Waveshape"
        param: "setWaveOscA"
        colorG: "synthParamGroup-D"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "invSawtooth"]
        value: 1
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
        value: "sawtooth"
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