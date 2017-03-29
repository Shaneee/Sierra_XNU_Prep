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
#pragma ident	"@(#)tst.tcp.ksh	1.1	06/08/28 SMI"

#
# This script tests that several of the the mib:::tcp* probes fire and fire
# with a valid args[0].
#
script()
{
	$dtrace -s /dev/stdin <<EOF
	mib:::tcpActiveOpens
	{
		opens = args[0];
	}

	mib:::tcpOutDataBytes
	{
		bytes = args[0];
	}

	mib:::tcpOutDataSegs
	{
		segs = args[0];
	}

	profile:::tick-10msec
	/opens && bytes && segs/
	{
		exit(0);
	}
EOF
}

telneter()
{
	while true; do
		finger @localhost
		/usr/bin/sleep 1
	done
}

dtrace=/usr/sbin/dtrace

telneter &
telneter=$!
script
status=$?

kill $telneter
exit $status
