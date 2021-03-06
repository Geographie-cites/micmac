extensions [csv rungeKuta]
__includes ["output_indicator.nls" "ui.nls" "network-generation.nls" "network-indicators.nls"
  "init_globals.nls"  "setup.nls"  "main.nls" "calibration_and_test.nls" "utils_reporters.nls" "utils_interactivity.nls" "lotterie.nls" "saveOrLoadCSVFile.nls"]

undirected-link-breed [ edges edge ]
breed [ nodes node ]
breed [ nodeTests nodeTest ]
breed [ MobileGroups MobileGroup ]

nodes-own [
  S_Node
  I_Node
  R_Node
  in-airport
  out-airport
  mobility-rate-node
  stock-to-flight
  tagged?
  id
  adjacent
  lost-passengers-in
  distance-from-other-nodes
]

nodeTests-own [S_Node I_Node R_Node]
MobileGroups-own [
  Origin-node
  Next-Node
  speed ; 800 air
  S_Group
  I_Group
  R_Group
  S_Group-init
]

edges-own
[
  a
  b
  edge_trafic
  edge_infected
  ]
@#$#@#$#@
GRAPHICS-WINDOW
425
10
906
492
-1
-1
7.7541
1
10
1
1
1
0
0
0
1
-30
30
-30
30
0
0
1
ticks
30.0

BUTTON
1290
1040
1394
1074
Create node
make-node
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1290
1074
1394
1108
Create edge
make-edge last1 last2 cyan
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1025
1075
1150
1109
Select nodes
select-node
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1395
1075
1508
1108
Remove edge
remove-selected-edge
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1395
1041
1507
1074
Remove node
remove-selected-node
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

INPUTBOX
245
150
335
210
integrationStep
0.01
1
0
Number

BUTTON
300
55
407
89
NIL
main-loop
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
1025
1150
1145
1183
gamma
gamma
0
1
0.0
0.001
1
NIL
HORIZONTAL

BUTTON
140
55
292
88
Setup Agents
Setup-Agents
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
10
10
130
51
*******************\n* Network Creation\n*******************
11
0.0
1

TEXTBOX
144
12
274
52
********************\n* Setup Simulation\n********************
11
0.0
1

SLIDER
1025
1181
1145
1214
birth
birth
0
1
0.0
0.01
1
NIL
HORIZONTAL

SLIDER
1025
1213
1145
1246
dead1
dead1
0
1
0.0
0.001
1
NIL
HORIZONTAL

SLIDER
1025
1244
1145
1277
dead2
dead2
0
1
0.0
0.001
1
NIL
HORIZONTAL

TEXTBOX
10
677
100
722
**************\nCalibration\n**************
12
0.0
1

MONITOR
10
830
107
875
NIL
gnbStepCalib
17
1
11

MONITOR
110
830
182
875
NIL
gdureeDt
5
1
11

SLIDER
10
140
240
173
number-nodes
number-nodes
2
1000
40.0
1
1
NIL
HORIZONTAL

SLIDER
10
175
240
208
radius-random-network
radius-random-network
3
15
10.0
1
1
NIL
HORIZONTAL

CHOOSER
10
93
240
138
network-choice
network-choice
"random" "load-file"
1

MONITOR
1335
370
1439
415
Pop total
compute-pop-total
2
1
11

MONITOR
184
830
281
875
NIL
guniteEspace
3
1
11

MONITOR
284
830
379
875
NIL
gspeed-factor
4
1
11

BUTTON
1154
1074
1289
1107
select node to infect
select-city-to-infect
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
5
45
120
78
setup Network
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1335
465
1440
510
Error Value
initial-population - compute-pop-total
10
1
11

BUTTON
1217
1040
1287
1074
Layout
Layout
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
970
730
1130
775
Duration of epidemy
gduration
0
1
11

MONITOR
650
630
860
675
Time to reach every node
gTimeToReachAllNodes
0
1
11

MONITOR
285
580
411
625
Max #Infected
gMaxI
2
1
11

MONITOR
285
627
410
672
Time Max #Infected
gtimeofmaxi
0
1
11

SLIDER
249
225
413
258
mobility-rate
mobility-rate
0
1
0.017
0.001
1
Per Day
HORIZONTAL

TEXTBOX
900
520
1050
561
***********\nStrategies\n***********
12
0.0
1

SWITCH
889
565
1019
598
S1_Quarantine
S1_Quarantine
1
1
-1000

SWITCH
889
601
1019
634
S2_Avoidance
S2_Avoidance
1
1
-1000

SWITCH
889
635
1019
668
S3_RiskCulture
S3_RiskCulture
1
1
-1000

SWITCH
889
670
1019
703
S4_Protection
S4_Protection
1
1
-1000

SLIDER
1025
565
1175
598
theta1
theta1
0
1
5.0E-4
0.0001
1
NIL
HORIZONTAL

MONITOR
10
900
149
945
#Airports (open entry)
count nodes with [in-airport = 1]
17
1
11

MONITOR
10
946
149
991
#Airports (open out)
count nodes with [out-airport = 1]
17
1
11

MONITOR
10
580
140
625
Total pop in airplanes
total-mobile-pop
17
1
11

MONITOR
765
1165
855
1210
I total
compute-pop-total-with-state \"I\"
2
1
11

MONITOR
765
1118
855
1163
S total
compute-pop-total-with-state \"S\"
2
1
11

MONITOR
765
1212
855
1257
R total
compute-pop-total-with-state \"R\"
2
1
11

PLOT
1225
540
1475
695
Cumulated Traffic Loss
NIL
NIL
0.0
100.0
0.0
1.0
true
false
"" ""
PENS
"Traffic Loss%" 1.0 0 -16777216 true "" "if gcumulated-pop-flight-real > 0 \n [Plot (gcumulated-pop-flight-expected - gcumulated-pop-flight-real) / gcumulated-pop-flight-expected * 100]"

SLIDER
1025
635
1175
668
pcr
pcr
0
1
0.96
0.01
1
NIL
HORIZONTAL

SLIDER
1025
670
1175
703
reduc-contagion
reduc-contagion
0
1
0.94
0.01
1
NIL
HORIZONTAL

MONITOR
485
580
644
625
Taux people infected (%)
gtotal-number-people-infected
2
1
11

MONITOR
650
580
859
625
Taux global Traffic reduction (%)
gout-cumulated-traffic-reduction
2
1
11

SLIDER
1025
600
1175
633
theta2
theta2
0
1
0.033
0.001
1
NIL
HORIZONTAL

PLOT
225
325
407
450
Cumulated Flought Population
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot  gcumulated-pop-flight-real"

TEXTBOX
485
530
740
575
*****************************************\n* Indicators at the end of the epidemy\n*****************************************
12
0.0
1

MONITOR
670
780
828
825
#Passengers-in lost
sum [lost-passengers-in] of nodes
17
1
11

MONITOR
485
680
618
725
Taux reduction (%)
gout-traffic-reduction-instantaneous * 100
2
1
11

MONITOR
485
730
625
775
Taux réduction Max (%)
gtaux-reduc-max * 100
2
1
11

TEXTBOX
305
15
415
56
******************\n* Run Simulation\n******************
11
0.0
1

TEXTBOX
1020
1030
1236
1065
*******************************\n* Network Interactive Creation
11
0.0
1

SWITCH
985
525
1202
558
strategy-redistribution
strategy-redistribution
1
1
-1000

TEXTBOX
10
528
177
568
*********************\n * Runtime Indicators \n*********************
11
0.0
1

MONITOR
10
630
90
675
#Airplanes
count MobileGroups
17
1
11

TEXTBOX
1250
565
1370
591
Cumulated Traffic Loss
11
0.0
1

INPUTBOX
340
150
420
210
Epsilon-stop
1.0
1
0
Number

MONITOR
95
630
280
675
Tot Pop Infected in Airplanes
gcumulated-infection-in-flight
2
1
11

TEXTBOX
1025
1125
1175
1143
Pour la suite ...
12
0.0
1

MONITOR
650
680
847
725
Effective Mobility Rate at End
gend-effective-mobility-rate
6
1
11

MONITOR
460
780
662
825
NIL
sum [stock-to-flight] of nodes
17
1
11

PLOT
400
835
675
1010
Stock-to-Flight of Node 1
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 2 -16777216 true "" "if sum [stock-to-flight] of nodes > 0 [ plot [stock-to-flight] of turtle 1]"

PLOT
680
835
980
1010
Instantaneous Effective Mobility Rate
NIL
NIL
0.0
10.0
0.0
0.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "if ticks > 0 [plot ginstantaneous-effective-mobility-rate]"

MONITOR
650
730
827
775
Effective duration Epidemy
( gDurationEpidemy-days  * ( gDuration / gnbStepCalib) )
17
1
11

PLOT
400
1015
655
1175
Mean size of flights
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 2 -16777216 true "" "if any? mobilegroups [plot mean [S_group + I_group + R_group] of mobilegroups]"

MONITOR
140
730
330
775
Population at calibrage node
gPopulation-At-Calibrage-node
17
1
11

MONITOR
10
785
172
830
NIL
gtotal-population-to-fly
17
1
11

MONITOR
175
785
392
830
NIL
gpotential-population-departure
17
1
11

MONITOR
835
780
965
825
NIL
gsum-passenger-canceled
17
1
11

MONITOR
835
730
965
775
duration of epidemy (Days)
round(gduration-days)
17
1
11

MONITOR
1000
795
1107
840
NIL
gpop-expected
17
1
11

MONITOR
250
270
397
315
NIL
gmobility-rate-by-tick
11
1
11

MONITOR
464
630
647
675
NIL
gcumulated-pop-flight-real
0
1
11

MONITOR
1174
724
1364
769
NIL
sum [edge_trafic] of edges
0
1
11

MONITOR
1174
774
1364
819
NIL
sum [edge_infected] of edges
0
1
11

CHOOSER
1395
730
1557
775
Map-Network?
Map-Network?
"No" "Trafic" "Infected Travellers"
2

PLOT
950
55
1225
260
SIR chosen city
time
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"S" 1.0 0 -13840069 true "" ""
"I" 1.0 0 -7500403 true "" ""
"R" 1.0 0 -2674135 true "" ""

BUTTON
950
265
1127
298
NIL
select-city-to-display
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
50
285
217
318
create csv network
create-csv
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
110
225
245
270
Output-Mapping
Output-Mapping
"Standard View" "Trafic" "Infected Travellers" "Airports Closed by Quarantine"
0

MONITOR
1135
265
1237
310
NIL
city-to-display
17
1
11

@#$#@#$#@
## WHAT IS IT?

This section could give a general understanding of what the model is trying to show or explain.

## HOW IT WORKS

This section could explain what rules the agents use to create the overall behavior of the model.

## HOW TO USE IT

This section could explain how to use the model, including a description of each of the items in the interface tab.

## THINGS TO NOTICE

This section could give some ideas of things for the user to notice while running the model.

## THINGS TO TRY

This section could give some ideas of things for the user to try to do (move sliders, switches, etc.) with the model.

## EXTENDING THE MODEL

This section could give some ideas of things to add or change in the procedures tab to make the model more complicated, detailed, accurate, etc.

## NETLOGO FEATURES

This section could point out any especially interesting or unusual features of NetLogo that the model makes use of, particularly in the Procedures tab.  It might also point out places where workarounds were needed because of missing features.

## RELATED MODELS

This section could give the names of models in the NetLogo Models Library or elsewhere which are of related interest.

## CREDITS AND REFERENCES

This section could contain a reference to the model's URL on the web if it has one, as well as any other necessary credits or references.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line-half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

van side
false
0
Polygon -7500403 true true 26 147 18 125 36 61 161 61 177 67 195 90 242 97 262 110 273 129 260 149
Circle -16777216 true false 43 123 42
Circle -16777216 true false 194 124 42
Polygon -16777216 true false 45 68 37 95 183 96 169 69
Line -7500403 true 62 65 62 103
Line -7500403 true 115 68 120 100
Polygon -1 true false 271 127 258 126 257 114 261 109
Rectangle -16777216 true false 19 131 27 142

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment-14nov2014" repetitions="50" runMetricsEveryStep="false">
    <setup>setup
setup-again-mobileagents</setup>
    <go>main-loop</go>
    <exitCondition>gduration-of-Epidemy &gt; 0</exitCondition>
    <metric>gI-Value-max</metric>
    <metric>gtime-I-Value-max</metric>
    <metric>gduration-of-Epidemy</metric>
    <metric>effective-mobility-rate</metric>
    <enumeratedValueSet variable="number-nodes">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S-At-Node">
      <value value="40000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Infect_One_Node?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mobility-rate">
      <value value="0.012"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="airplane-size">
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TerritorySize-km">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DurationEpidemy-days">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha-airplane">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta-airplane">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S1_Quarantine">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S2_Avoidance">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S3_RiskCulture">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S4_Protection">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="redistribution?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <steppedValueSet variable="theta1" first="0" step="0.01" last="1"/>
  </experiment>
  <experiment name="experiment-20nov2014" repetitions="50" runMetricsEveryStep="false">
    <setup>setup
setup-again-mobileagents</setup>
    <go>main-loop</go>
    <exitCondition>gduration-of-Epidemy &gt; 0</exitCondition>
    <metric>gI-Value-max</metric>
    <metric>gtime-I-Value-max</metric>
    <metric>gduration-of-Epidemy</metric>
    <metric>effective-mobility-rate</metric>
    <metric>gcumulated-pop-flight-expected</metric>
    <metric>gcumulated-pop-flight-real</metric>
    <enumeratedValueSet variable="number-nodes">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S-At-Node">
      <value value="40000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Infect_One_Node?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mobility-rate">
      <value value="0.012"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="airplane-size">
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TerritorySize-km">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DurationEpidemy-days">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha-airplane">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta-airplane">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S1_Quarantine">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S2_Avoidance">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S3_RiskCulture">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S4_Protection">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="redistribution?">
      <value value="false"/>
    </enumeratedValueSet>
    <steppedValueSet variable="theta1" first="0" step="0.001" last="0.2"/>
  </experiment>
  <experiment name="Quarantaine-Janv2015" repetitions="50" runMetricsEveryStep="false">
    <setup>setup
Setup-Agents</setup>
    <go>main-loop</go>
    <exitCondition>gduration-of-Epidemy &gt; 0</exitCondition>
    <metric>gI-Value-max</metric>
    <metric>gtime-I-Value-max</metric>
    <metric>gduration-of-Epidemy</metric>
    <metric>effective-mobility-rate</metric>
    <metric>gcumulated-pop-flight-expected</metric>
    <metric>gcumulated-pop-flight-real</metric>
    <enumeratedValueSet variable="number-nodes">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S-At-Node">
      <value value="40000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Infect_One_Node?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mobility-rate">
      <value value="0.012"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="airplane-size">
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TerritorySize-km">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DurationEpidemy-days">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha-airplane">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta-airplane">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S1_Quarantine">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S2_Avoidance">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S3_RiskCulture">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S4_Protection">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="redistribution?">
      <value value="false"/>
    </enumeratedValueSet>
    <steppedValueSet variable="theta1" first="1.0E-4" step="0.001" last="0.1"/>
  </experiment>
  <experiment name="ImpactMobiliteAvecContagion-Janv2015" repetitions="30" runMetricsEveryStep="false">
    <setup>setup
Setup-Agents</setup>
    <go>main-loop</go>
    <exitCondition>gduration-of-Epidemy &gt; 0</exitCondition>
    <metric>gI-Value-max</metric>
    <metric>gtime-I-Value-max</metric>
    <enumeratedValueSet variable="number-nodes">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S-At-Node">
      <value value="40000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Infect_One_Node?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mobility-rate">
      <value value="0.12"/>
    </enumeratedValueSet>
    <steppedValueSet variable="airplane-size" first="1" step="50" last="800"/>
    <enumeratedValueSet variable="TerritorySize-km">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DurationEpidemy-days">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha-airplane">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta-airplane">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S1_Quarantine">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S2_Avoidance">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S3_RiskCulture">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S4_Protection">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="ImpactMobiliteSansContagion-Janv2015" repetitions="30" runMetricsEveryStep="false">
    <setup>setup
Setup-Agents</setup>
    <go>main-loop</go>
    <exitCondition>gduration-of-Epidemy &gt; 0</exitCondition>
    <metric>gI-Value-max</metric>
    <metric>gtime-I-Value-max</metric>
    <enumeratedValueSet variable="number-nodes">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S-At-Node">
      <value value="40000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Infect_One_Node?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mobility-rate">
      <value value="0.12"/>
    </enumeratedValueSet>
    <steppedValueSet variable="airplane-size" first="1" step="50" last="800"/>
    <enumeratedValueSet variable="TerritorySize-km">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DurationEpidemy-days">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha-airplane">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta-airplane">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S1_Quarantine">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S2_Avoidance">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S3_RiskCulture">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S4_Protection">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="AvoidanceRedibTrue" repetitions="50" runMetricsEveryStep="false">
    <setup>setup
Setup-Agents</setup>
    <go>main-loop</go>
    <exitCondition>gduration-of-Epidemy &gt; 0</exitCondition>
    <metric>gI-Value-max</metric>
    <metric>gtime-I-Value-max</metric>
    <metric>gduration-of-Epidemy</metric>
    <metric>effective-mobility-rate</metric>
    <metric>gcumulated-pop-flight-expected - gcumulated-pop-flight-real</metric>
    <metric>gpercolation-time</metric>
    <enumeratedValueSet variable="number-nodes">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S-At-Node">
      <value value="40000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Infect_One_Node?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mobility-rate">
      <value value="0.012"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="airplane-size">
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TerritorySize-km">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DurationEpidemy-days">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha-airplane">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta-airplane">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S1_Quarantine">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S2_Avoidance">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S3_RiskCulture">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S4_Protection">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="redistribution?">
      <value value="true"/>
    </enumeratedValueSet>
    <steppedValueSet variable="theta2" first="0" step="0.005" last="0.05"/>
  </experiment>
  <experiment name="RiskCulture-Fev2015" repetitions="50" runMetricsEveryStep="false">
    <setup>setup
Setup-Agents</setup>
    <go>main-loop</go>
    <exitCondition>gduration-of-Epidemy &gt; 0</exitCondition>
    <metric>gI-Value-max</metric>
    <metric>gtime-I-Value-max</metric>
    <metric>gduration-of-Epidemy</metric>
    <metric>effective-mobility-rate</metric>
    <metric>gcumulated-pop-flight-expected - gcumulated-pop-flight-real</metric>
    <metric>gpercolation-time</metric>
    <enumeratedValueSet variable="number-nodes">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S-At-Node">
      <value value="40000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Infect_One_Node?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mobility-rate">
      <value value="0.012"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="airplane-size">
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TerritorySize-km">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DurationEpidemy-days">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha-airplane">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta-airplane">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S1_Quarantine">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S2_Avoidance">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S3_RiskCulture">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S4_Protection">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="redistribution?">
      <value value="true"/>
    </enumeratedValueSet>
    <steppedValueSet variable="pcr" first="0.005" step="0.05" last="1"/>
  </experiment>
  <experiment name="Quarantaine-RedibTrue" repetitions="50" runMetricsEveryStep="false">
    <setup>setup
Setup-Agents</setup>
    <go>main-loop</go>
    <exitCondition>gduration-of-Epidemy &gt; 0</exitCondition>
    <metric>gI-Value-max</metric>
    <metric>gtime-I-Value-max</metric>
    <metric>gduration-of-Epidemy</metric>
    <metric>effective-mobility-rate</metric>
    <metric>gcumulated-pop-flight-expected - gcumulated-pop-flight-real</metric>
    <metric>gpercolation-time</metric>
    <enumeratedValueSet variable="number-nodes">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S-At-Node">
      <value value="40000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Infect_One_Node?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mobility-rate">
      <value value="0.012"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="airplane-size">
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TerritorySize-km">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DurationEpidemy-days">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha-airplane">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta-airplane">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S1_Quarantine">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S2_Avoidance">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S3_RiskCulture">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S4_Protection">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="redistribution?">
      <value value="true"/>
    </enumeratedValueSet>
    <steppedValueSet variable="theta1" first="0" step="0.005" last="0.05"/>
  </experiment>
  <experiment name="AvoidanceRedibFalse" repetitions="50" runMetricsEveryStep="false">
    <setup>setup
Setup-Agents</setup>
    <go>main-loop</go>
    <exitCondition>gduration-of-Epidemy &gt; 0</exitCondition>
    <metric>gI-Value-max</metric>
    <metric>gtime-I-Value-max</metric>
    <metric>gduration-of-Epidemy</metric>
    <metric>effective-mobility-rate</metric>
    <metric>gcumulated-pop-flight-expected - gcumulated-pop-flight-real</metric>
    <metric>gpercolation-time</metric>
    <enumeratedValueSet variable="number-nodes">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S-At-Node">
      <value value="40000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Infect_One_Node?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mobility-rate">
      <value value="0.012"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="airplane-size">
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TerritorySize-km">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DurationEpidemy-days">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha-airplane">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta-airplane">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S1_Quarantine">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S2_Avoidance">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S3_RiskCulture">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S4_Protection">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="redistribution?">
      <value value="false"/>
    </enumeratedValueSet>
    <steppedValueSet variable="theta2" first="0" step="0.005" last="0.05"/>
  </experiment>
  <experiment name="Quarantaine-RedibFalse" repetitions="50" runMetricsEveryStep="false">
    <setup>setup
Setup-Agents</setup>
    <go>main-loop</go>
    <exitCondition>gduration-of-Epidemy &gt; 0</exitCondition>
    <metric>gI-Value-max</metric>
    <metric>gtime-I-Value-max</metric>
    <metric>gduration-of-Epidemy</metric>
    <metric>effective-mobility-rate</metric>
    <metric>gcumulated-pop-flight-expected - gcumulated-pop-flight-real</metric>
    <metric>gpercolation-time</metric>
    <enumeratedValueSet variable="number-nodes">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S-At-Node">
      <value value="40000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Infect_One_Node?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mobility-rate">
      <value value="0.012"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="airplane-size">
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="TerritorySize-km">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="DurationEpidemy-days">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha-airplane">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="beta-airplane">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S1_Quarantine">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S2_Avoidance">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S3_RiskCulture">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="S4_Protection">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="redistribution?">
      <value value="false"/>
    </enumeratedValueSet>
    <steppedValueSet variable="theta1" first="0" step="0.005" last="0.05"/>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
1
@#$#@#$#@
