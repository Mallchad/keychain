#!/bin/bash
if [[ $KDEWM != "kwin" ]]
then
	export KDEWM=awesome
fi
exec startplasma-x11
