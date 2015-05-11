In total, there are 6 simulation. 
1. One_Belt: Simulate only one belt 
2. Totally_Decentralized_Conveyor: Each belt has one local LLC.
3. Totally_centralized_Conveyor: Only one centralzied controller.
4. Partially decentralized Conveyor: Each belt has one local LLC and also considers preceeding belts' speed.
5. 2level_global_decentralized Conveyor: Each belt has one local LLC make short-term prediction. A second level controller 
                                         make long-term prediction.
6. 2level_global_centralized Conveyor: The function is same with 2level_global_decentralized, but the system only has one 
                                       concentralized controller.

To run the simulation, please browse each simulation folder. 
Right click rc_init.m select run, and select change folders. After that please right click rc_init.m and select run again
to run this initialization file first. Finally please open the .mdl file to run the simulation.

In simulation 1,2,3,4, you can change the look ahead step in rc_init.m, the variable is rc_LOOKAHEAD_STEPS.
In simulation 5,6, you can change the look ahead step in rc_init.m, the variable is rc_LOOKAHEAD_STEP_GLOBAL_CHANGE.

In result, you can check the 
- total throughput, 
- total energy consumption, 
- total cpu time, 
- total speed switch cost 
- and total system utility. 

You can also check the scopes in mdl file.
