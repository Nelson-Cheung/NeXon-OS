#ifndef MATH_H
#define MATH_H

#include "type.h"

namespace stdmath
{
    dword roundup(dword dividend, dword divisor)
    {
        return (dividend + divisor - 1) / divisor;
    }
} // namespace stdmath
#endif