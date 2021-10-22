#!/bin/sh

BASEDIR=`pwd`

if [ ! -d "$BASEDIR" ]; then
    mkdir "$BASEDIR"
fi


# toy (testing dataset)
if [ ! -d "$BASEDIR/toy" ]; then
    echo Downloading toy
    cd $BASEDIR
    curl -O https://web.informatik.uni-mannheim.de/pi1/kge-datasets/toy.tar.gz
    tar xvf toy.tar.gz
else
    echo toy already present
fi
if [ ! -f "$BASEDIR/toy/dataset.yaml" ]; then
    python preprocess/preprocess_default.py toy
else
    echo toy already prepared
fi


# fb15k
if [ ! -d "$BASEDIR/fb15k" ]; then
    echo Downloading fb15k
    cd $BASEDIR
    curl -O https://web.informatik.uni-mannheim.de/pi1/kge-datasets/fb15k.tar.gz
    tar xvf fb15k.tar.gz
    cd fb15k
    case "$(uname -s)" in
        CYGWIN*|MINGW32*|MSYS*)
            cmd.exe /c mklink train.txt freebase_mtr100_mte100-train.txt
            cmd.exe /c mklink valid.txt freebase_mtr100_mte100-valid.txt
            cmd.exe /c mklink test.txt freebase_mtr100_mte100-test.txt
            ;;
        *)
            ln -s freebase_mtr100_mte100-train.txt train.txt
            ln -s freebase_mtr100_mte100-valid.txt valid.txt
            ln -s freebase_mtr100_mte100-test.txt test.txt
            ;;
    esac
    cd ..
else
    echo fb15k already present
fi
if [ ! -f "$BASEDIR/fb15k/dataset.yaml" ]; then
    python preprocess/preprocess_default.py fb15k
else
    echo fb15k already prepared
fi

# fb15k-237
if [ ! -d "$BASEDIR/fb15k-237" ]; then
    echo Downloading fb15k-237
    cd $BASEDIR
    curl -O https://web.informatik.uni-mannheim.de/pi1/kge-datasets/fb15k-237.tar.gz
    tar xvf fb15k-237.tar.gz
else
    echo fb15k-237 already present
fi
if [ ! -f "$BASEDIR/fb15k-237/dataset.yaml" ]; then
    python preprocess/preprocess_default.py fb15k-237
else
    echo fb15k-237 already prepared
fi

# wn18
if [ ! -d "$BASEDIR/wn18" ]; then
    echo Downloading wn18
    cd $BASEDIR
    curl -O https://web.informatik.uni-mannheim.de/pi1/kge-datasets/wn18.tar.gz
    tar xvf wn18.tar.gz
    cd wn18
    case "$(uname -s)" in
        CYGWIN*|MINGW32*|MSYS*)
            cmd.exe /c mklink train.txt wordnet-mlj12-train.txt
            cmd.exe /c mklink valid.txt wordnet-mlj12-valid.txt
            cmd.exe /c mklink test.txt wordnet-mlj12-test.txt
            ;;
        *)
            ln -s wordnet-mlj12-train.txt train.txt
            ln -s wordnet-mlj12-valid.txt valid.txt
            ln -s wordnet-mlj12-test.txt test.txt
            ;;
    esac
    cd ..
else
    echo wn18 already present
fi
if [ ! -f "$BASEDIR/wn18/dataset.yaml" ]; then
    python preprocess/preprocess_default.py wn18
else
    echo wn18 already prepared
fi

# wnrr
if [ ! -d "$BASEDIR/wnrr" ]; then
    echo Downloading wnrr
    cd $BASEDIR
    curl -O https://web.informatik.uni-mannheim.de/pi1/kge-datasets/wnrr.tar.gz
    tar xvf wnrr.tar.gz
else
    echo wnrr already present
fi
if [ ! -f "$BASEDIR/wnrr/dataset.yaml" ]; then
    python preprocess/preprocess_default.py wnrr
else
    echo wnrr already prepared
fi


# yago3-10
if [ ! -d "$BASEDIR/yago3-10" ]; then
    echo Downloading yago3-10
    cd $BASEDIR
    curl -O https://web.informatik.uni-mannheim.de/pi1/kge-datasets/yago3-10.tar.gz
    tar xvf yago3-10.tar.gz
else
    echo yago3-10 already present
fi
if [ ! -f "$BASEDIR/yago3-10/dataset.yaml" ]; then
    python preprocess/preprocess_default.py yago3-10
else
    echo yago3-10 already prepared
fi


# kinship
if [ ! -d "$BASEDIR/kinship" ]; then
    echo Downloading kinship
    cd $BASEDIR
    curl -O https://web.informatik.uni-mannheim.de/pi1/kge-datasets/kinship.tar.gz
    tar xvf kinship.tar.gz
else
    echo kinship already present
fi
if [ ! -f "$BASEDIR/kinship/dataset.yaml" ]; then
    python preprocess/preprocess_default.py kinship
else
    echo kinship already prepared
fi

# nations
if [ ! -d "$BASEDIR/nations" ]; then
    echo Downloading nations
    cd $BASEDIR
    curl -O https://web.informatik.uni-mannheim.de/pi1/kge-datasets/nations.tar.gz
    tar xvf nations.tar.gz
else
    echo nations already present
fi
if [ ! -f "$BASEDIR/nations/dataset.yaml" ]; then
    python preprocess/preprocess_default.py nations
else
    echo nations already prepared
fi
