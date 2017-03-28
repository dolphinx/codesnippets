#include "sqlite3ext.h"
#include <string.h>
SQLITE_EXTENSION_INIT1

static void matchFunc(sqlite3_context *context, int argc, sqlite3_value **argv)
{
	char *text = sqlite3_value_text(argv[0]);
	if (text)
	{
		for (char * start = text; *start; ++start)
		{
			if (*start >= 'a' && *start <= 'z')
				*start -= 'a' - 'A';
		}
	}

	char *filter = sqlite3_value_text(argv[1]);
	char *start = filter;
	while (*start == ' ')
	{
		++start;
	}

	size_t found;
	if (text)
	{
		found = 1;
		while (*start)
		{
			char* end = strchr(start, ' ');
			if (end)
			{
				*end = 0;
				found = strstr(text, start);
				*end = ' ';
				if (!found)
					break;
				start = end + 1;
				while (*start == ' ')
				{
					++start;
				}
			}
			else
			{
				found = strstr(text, start);
				break;
			}
		}
	}
	else
		found = *start == 0;
	sqlite3_result_int(context, found ? 1 : 0);
}

__declspec(dllexport)
int sqlite3_extension_init(sqlite3 *db, char **pzErrMsg, const sqlite3_api_routines *pApi)
{
	SQLITE_EXTENSION_INIT2(pApi)
	sqlite3_create_function(db, "match", 2, SQLITE_ANY, NULL, matchFunc, NULL, NULL);
	return 0;
}
