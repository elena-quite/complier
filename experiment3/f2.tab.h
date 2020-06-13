/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_F2_TAB_H_INCLUDED
# define YY_YY_F2_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDE = 258,
    INT_DEX = 259,
    INT_HEX = 260,
    INT_OCT = 261,
    FLOAT_DEX = 262,
    FLOAT_HEX = 263,
    FLOAT_OCT = 264,
    assignop = 265,
    greater_than = 266,
    less_than = 267,
    plus = 268,
    minus = 269,
    divi = 270,
    star = 271,
    LP = 272,
    RP = 273,
    IF = 274,
    THEN = 275,
    ELSE = 276,
    DO = 277,
    WHILE = 278,
    semi = 279,
    comma = 280,
    LE = 281,
    GE = 282,
    and = 283,
    or = 284,
    not = 285,
    MAIN = 286,
    STRUCT = 287,
    RETURN = 288,
    TYPE = 289,
    LB = 290,
    RB = 291,
    LC = 292,
    RC = 293
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_F2_TAB_H_INCLUDED  */
