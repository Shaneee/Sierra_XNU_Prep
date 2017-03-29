#!/bin/sh -p
#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#

#
# Copyright 2006 Sun Microsystems, Inc.  All rights reserved.
# Use is subject to license terms.
#

#ident	"@(#)tst.ELFGenerationWithO.d.ksh	1.1	06/08/28 SMI"

##
#
# ASSERTION:
# Using -G option with dtrace utility produces an ELF file containing a
# DTrace program. The output file can be named as required using the
# -o option in conjunction with the -G option.
#
# SECTION: dtrace Utility/-G Option;
# 	dtrace Utility/-o Option
#
##

script()
{
	$dtrace -G -o outputFile -s /dev/stdin <<EOF
	BEGIN
	{
		printf("This test should compile.\n");
		exit(0);
	}
EOF
}

dtrace=/usr/sbin/dtrace

script
status=$?

if [ "$status" -ne 0 ]; then
	echo $tst: dtrace failed
	exit $status
fi

if [ ! -a "outputFile" ]; then
	echo $tst: file not generated
	exit 1
fi

if [ -f /usr/lib/dtrace/darwin.d ]; then
/bin/rm -f "outputFile"
else
/usr/bin/rm -f "outputFile"
fi
exit 0
