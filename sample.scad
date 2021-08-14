include <pulley-generator.scad>

Test();

translate( [-50,0,0] )
MapFromOldExample();

module Test() {
    
    //
    // BASIC for 3D printing
    //
    NEMA17_SHAFT_DIA      = 5.2;
    globalToothWidthTweak = 0.2;
    globalToothDepthTweak = 0;
    
    translate( [50,0,0] )
    pulley3DP(
        model           = "MXL",
        teethCount      = 20,
        beltWidth       = 12,
        shaftDiameter   = NEMA17_SHAFT_DIA,
        toothWidthTweak = globalToothWidthTweak,
        toothDepthTweak = globalToothDepthTweak
    );
    
    //
    // COMPLETE for 3D printing
    //
    M3_NUT = [ "hex", 3.2, 5.7, 2.7 ]; // hex, 3.2 screw diameter, 5.7 nut face height, 2.7 thick
    captiveNuts = [2,90,1.2];          // 2 nuts, 90 degs apart, 1.2 away from motor shaft
    
    translate( [100,0,0] )
    pulley(
        model           = "MXL",
        teethCount      = 60,
        beltWidth       = 6,
        shaftDiameter   = 5.2,          // NEMA17
        retainerInfo    = [2,1,1],      // 2mm bigger, taper 1, up 1
        idlerInfo       = [2,1,1],      // 2mm bigger, taper 1, down 1
        baseInfo        = [20,8],       // 20 diameter, 8 height
        nutProfile      = ["hex",3.2,5.7,2.7],
                                        // hex head, 3.2mm shaft diameter, 
                                        // 5.7 nut face height, 2.7 nut thickness
        captiveNuts     = [3,120,1.2],  // 3 nuts, at 120 deg, 1.2 distance from motor shaft
        toothWidthTweak = globalToothWidthTweak,
        toothDepthTweak = globalToothDepthTweak,
        autoFlip        = true          // flip if base is bigger
    );
    
    //
    // for CAD representation only
    //
    translate( [150,0,0] )
    pulleyCAD(
        model          = "GT2 2mm",
        teethCount     = 60,
        beltWidth      = 6,
        shaftDiameter  = 8,
        pulleyDiameter = 42,
        retainerHeight = 1,
        idlerHeight    = 1,
        baseDiameter   = 20,
        baseHeight     = 6
    );
    
    //
    // PARTS
    //

    captiveGrubAndNut( M3_NUT,
        [
            3,    // 3 nuts
            120,  // 120 degrees apart
            10    // 10 away from center
        ],
        10,       // height of nut entrance
        15 );     // length of screw shaft
    
    translate( [0,0,10] )
    pulleyBase(
        20,     // diameter
        20,     // height
        30      // upper section, bigger so no taper
    );
        
    translate( [0,0,40] )
    pulleyIdler(
        10,     // for smoothing the model only
        30,     // main diameter
        [
            2,  // offset outwards
            1,  // taper downwards
            2   // extra downwards
        ] );
        
    translate( [0,0,60] )
    pulleyTeeth( "AT5", 20, 10 );

    translate( [0,0,80] )
    pulleyRetainer(
        10,     // for smoothing the model only
        30,     // main diameter
        [
            2,  // offset outwards
            1,  // taper upwards
            2   // extra upwards
        ] );
           
}

module MapFromOldExample() {
    
    // sample showing how to map variables from previous examples
    
    teeth = 20;
    profile = 1;
    pulley_t_ht = 12;
  
    retainer_ht = 1;
    retainer_flat_width = 1.0;
    idler_ht = 1;
    idler_flat_width = 1.0;
   
    pulley_b_dia = 25;
    pulley_b_ht = 8;
    
    no_of_nuts = 1;
    nut_angle = 90;
    nut_shaft_distance = 1.2;

    additional_tooth_width = 0.2;
    additional_tooth_depth = 0.0;
   
    NEMA17_SHAFT_DIA = 5.2;    
    
    M3_NUT_HEX    = 1;
    M3_DIA        = 3.2;    
    M3_NUT_FLATS  = 5.7;
    M3_NUT_DEPTH  = 2.7;
    
    // map data from old sample
    
    model           = models[ profile-1 ];
    beltWidth       = pulley_t_ht;
    shaftDiameter   = NEMA17_SHAFT_DIA;
    retainerInfo    = [ retainer_ht, retainer_ht, retainer_flat_width ];
    idlerInfo       = [ idler_ht, idler_ht, idler_flat_width ];
    baseInfo        = [ pulley_b_dia, pulley_b_ht ];
    nutShape        = (M3_NUT_HEX==1?"hex":"square");    
    nutProfile      = [ nutShape, M3_DIA, M3_NUT_FLATS, M3_NUT_DEPTH ];
    captiveNuts     = [ no_of_nuts, nut_angle, nut_shaft_distance ];
    toothWidthTweak = additional_tooth_width;
    toothDepthTweak = additional_tooth_depth;
    
    pulley(
        model,
        teeth,
        beltWidth,
        shaftDiameter,
        retainerInfo,
        idlerInfo,
        baseInfo,
        nutProfile,
        captiveNuts,
        toothWidthTweak,
        toothDepthTweak
    );
}
