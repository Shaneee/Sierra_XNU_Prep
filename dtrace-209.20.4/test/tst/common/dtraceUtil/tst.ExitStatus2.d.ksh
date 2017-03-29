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

#ident	"@(#)tst.ExitStatus2.d.ksh	1.1	06/08/28 SMI"

##
#
# ASSERTION:
# When invalid command line options or arguments are specified an exit status
# of 2 is returned.
#
# SECTION: dtrace Utility/Exit Status
#
##

dtrace=/usr/sbin/dtrace

$dtrace -9
status=$?

if [ "$status" -ne 2 ]; then
	echo $tst: dtrace failed
	exit 1
fi

exit 0
