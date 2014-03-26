define [], ()->

  drumkitParams = {}
  drumkitParams.basicKit =
  [
    [
      [
        label: "SAMPLE"
        param: "setVolA"
        colorG: "synthParamGroup-C"
        type: "loadSample"
        value: 0.05
      ]
      [
        label: "OSC-B Waveshape"
        param: "setWaveOscB"
        colorG: "synthParamGroup-C"
        type: "button"
        values: ["sine", "square", "pulse", "triangle"]
        value: "sawtooth"
      ]
    ]
    [
      [
        label: "Start Sample"
        param: "setFreq"
        colorG: "synthParamGroup-A"
        type: "slider"
        range:[0, 100]
        step:0.01
        value: 0
      ]
      [
        label: "End Sample"
        param: "setFreq"
        colorG: "synthParamGroup-E"
        type: "slider"
        range:[0, 100]
        step:0.01
        value: 100
      ]
    ]
  ]
  drumkitParams