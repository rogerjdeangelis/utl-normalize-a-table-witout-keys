Normalize a table witout keys                                                                           
                                                                                                        
  Two Solutions                                                                                         
                                                                                                        
      1. utl_gather                                                                                     
         by Alea Iacta (preffered solution)                                                             
         https://github.com/clindocu                                                                    
                                                                                                        
      3. Proc transpose (requires unique records)                                                       
         Does not transpose duplicate observations                                                      
         (Bug or feature?)                                                                              
                                                                                                        
                                                                                                        
github                                                                                                  
https://tinyurl.com/y69z66ko                                                                            
https://github.com/rogerjdeangelis/utl-normalize-a-table-witout-keys                                    
                                                                                                        
SAS Forum                                                                                               
https://tinyurl.com/y6oyzgl3                                                                            
https://communities.sas.com/t5/SAS-Programming/Need-to-create-one-variable-from-many/m-p/570148         
                                                                                                        
macros                                                                                                  
https://tinyurl.com/y9nfugth                                                                            
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories              
                                                                                                        
                                                                                                        
*_                   _                                                                                  
(_)_ __  _ __  _   _| |_                                                                                
| | '_ \| '_ \| | | | __|                                                                               
| | | | | |_) | |_| | |_                                                                                
|_|_| |_| .__/ \__,_|\__|                                                                               
        |_|                                                                                             
;                                                                                                       
                                                                                                        
                                                                                                        
data have;                                                                                              
input Visit$ cat1$ cat2$;                                                                               
cards4;                                                                                                 
base line Gait normal                                                                                   
day1 Stand weak                                                                                         
;;;;                                                                                                    
run;quit;                                                                                               
                                                                                                        
                                                                                                        
*            _               _                                                                          
  ___  _   _| |_ _ __  _   _| |_                                                                        
 / _ \| | | | __| '_ \| | | | __|                                                                       
| (_) | |_| | |_| |_) | |_| | |_                                                                        
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                       
                |_|                                                                                     
;                                                                                                       
                                                                                                        
UTL GATHER OUTPUT (should move format type to dimension table)                                          
                                                                                                        
WORK.HAVXPO total obs=9 (will handle dup obs)                                                           
                                                                                                        
Obs     VAR      VAL     _COLFORMAT    _COLTYP                                                          
                                                                                                        
 1     VISIT    base        $8.           C                                                             
 2     CAT1     line        $8.           C                                                             
 3     CAT2     Gait        $8.           C                                                             
 4     VISIT    day1        $8.           C                                                             
 5     CAT1     Stand       $8.           C                                                             
 6     CAT2     weak        $8.           C                                                             
 7     VISIT    day1        $8.           C                                                             
 8     CAT1     Stand       $8.           C                                                             
 9     CAT2     weak        $8.           C                                                             
                                                                                                        
                                                                                                        
TRANSPOSE OUTPUT                                                                                        
                                                                                                        
Up to 40 obs from HAVNRM total obs=6                                                                    
                                                                                                        
Obs    _NAME_    COL1                                                                                   
                                                                                                        
 1     VISIT     base                                                                                   
 2     CAT1      line                                                                                   
 3     CAT2      Gait                                                                                   
 4     VISIT     day1                                                                                   
 5     CAT1      Stand                                                                                  
 6     CAT2      weak                                                                                   
                                                                                                        
                                                                                                        
*____        _       _   _                                                                              
/ ___|  ___ | |_   _| |_(_) ___  _ __  ___                                                              
\___ \ / _ \| | | | | __| |/ _ \| '_ \/ __|                                                             
 ___) | (_) | | |_| | |_| | (_) | | | \__ \                                                             
|____/ \___/|_|\__,_|\__|_|\___/|_| |_|___/                                                             
                                                                                                        
;                                                                                                       
                                                                                                        
*_                  _   _                                                                               
/ |      __ _  __ _| |_| |__   ___ _ __                                                                 
| |     / _` |/ _` | __| '_ \ / _ \ '__|                                                                
| |_   | (_| | (_| | |_| | | |  __/ |                                                                   
|_(_)   \__, |\__,_|\__|_| |_|\___|_|                                                                   
        |___/                                                                                           
;                                                                                                       
                                                                                                        
%utl_gather(have,var,val,,havXpo,valFormat=$8.,withFormats=Y);                                          
                                                                                                        
                                                                                                        
*____       _                                                                                           
|___ \     | |_ _ __ __ _ _ __  ___ _ __   ___  ___  ___                                                
  __) |    | __| '__/ _` | '_ \/ __| '_ \ / _ \/ __|/ _ \                                               
 / __/ _   | |_| | | (_| | | | \__ \ |_) | (_) \__ \  __/                                               
|_____(_)   \__|_|  \__,_|_| |_|___/ .__/ \___/|___/\___|                                               
                                   |_|                                                                  
;                                                                                                       
                                                                                                        
proc transpose data=have out=havNrm(keep=_name_ col1);                                                  
by _all_;                                                                                               
var _all_;                                                                                              
run;quit;                                                                                               
                                                                                                        
                                                                                                        
                                                                                                        
                                                                                                        
