for MASS_H3 in 320 450 1000 # 600 700 800 900 1000
do



for MASS_H2 in 60 70 75 80 85 90 95 100 110 120 130 150 170 190 250 300 350 400 450 500 550 600 650 700 750 800 850
do

SUM=$((MASS_H2+125))

if [ "$SUM" -gt "$MASS_H3" ]
then
   echo "Skipping "$MASS_H2" "$MASS_H3
   continue      # Skip rest of this particular loop iteration.
fi

python add_entry.py --mhigh $MASS_H3 --mlow $MASS_H2


done

python ../scripts/SkimManager.py --nick "NMSSMM${MASS_H3}h1M125tautauh2M.*_RunIIFall17MiniAODv2_PU2017_13TeV_MINIAOD_madgraph-pythia8_v1" --init -w /nfs/dust/cms/user/jbechtel/kappa_skim_workdir/nmssm_skims_${MASS_H3} -b naf --resubmit-with-gc -e 20000 


for MASS_H2 in 60 70 75 80 85 90 95 100 110 120 130 150 170 190 250 300 350 400 450 500 550 600 650 700 750 800 850
do
SUM=$((MASS_H2+125))

if [ "$SUM" -gt "$MASS_H3" ]
then
   echo "Skipping "$MASS_H2" "$MASS_H3
   continue      # Skip rest of this particular loop iteration.
fi

cp  miniAOD_lists/M${MASS_H3}_h1_M125_tautau_h2_M${MASS_H2}_bb_miniAOD.txt /nfs/dust/cms/user/jbechtel/kappa_skim_workdir/nmssm_skims_${MASS_H3}/gc_cfg/.


sed 's/dataset = NMSSMM'${MASS_H3}'h1M125tautauh2M'${MASS_H2}'_RunIIFall17MiniAODv2_PU2017_13TeV_MINIAOD_madgraph-pythia8_v1 :/dataset = NMSSMM'${MASS_H3}'h1M125tautauh2M'${MASS_H2}'_RunIIFall17MiniAODv2_PU2017_13TeV_MINIAOD_madgraph-pythia8_v1 : list:M'${MASS_H3}'_h1_M125_tautau_h2_M'${MASS_H2}'_bb_miniAOD.txt/g' -i /nfs/dust/cms/user/jbechtel/kappa_skim_workdir/nmssm_skims_${MASS_H3}/gc_cfg/NMSSMM${MASS_H3}h1M125tautauh2M${MASS_H2}_RunIIFall17MiniAODv2_PU2017_13TeV_MINIAOD_madgraph-pythia8_v1.conf

done

done
