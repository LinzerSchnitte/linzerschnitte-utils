(ns linzertone.core 
  (:use overtone.live))


(demo 1 (pan2 (* 0.3 (sin-osc 400)) 0))

(definst lstone [freq 400 dur 1.0]
  (* (env-gen (perc 0.0 dur 1 80) :action FREE)
     (* 0.3 (sin-osc freq))))

(stop)





(def metro (metronome 20))
(metro)
; Our bar is a map of beat to instruments to play

(def bar {0   [100]
          0.5 [200]
          1   [300]
          1.5 [400]
          2   [1000]
          2.5 [800 200]
          3   [700 300]
          3.5 [500]})

; For every tick of the metronome, we loop through all our beats
; and find the apropriate one my taking the metronome tick mod 4.
; Then we play all the instruments for that beat.

(defn player
  [tick]
  (dorun
    (for [k (keys bar)]
      (let [beat (Math/floor k)
            offset (- k beat)]
           (if (== 0 (mod (- tick beat) 4))
               (let [freqs (bar k)]
                    (dorun
                      (for [freq freqs]
                        (at (metro (+ offset tick)) (lstone freq 0.4))))))))))

;; define a run fn which will call our player fn for each beat and will schedule
;; itself to be called just before the next beat

(defn run-sequencer
  [m]
  (let [beat (m)]
    (player beat)
    (apply-by (m (inc beat))  #'run-sequencer [m])))

;; make beats! Edit bar whilst the beat is playing to make live changes.
(run-sequencer metro)
(stop)
