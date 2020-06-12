#!/bin/bash
grep -r '\b(sed)\b'
grep -r '^m' 
grep -r '[0-9]\{3\}' 
grep -r '\becho\b \b.*\b \b.*\b \b.*\b'
grep -r '^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*?[!@#$%&*]).{8,}$'