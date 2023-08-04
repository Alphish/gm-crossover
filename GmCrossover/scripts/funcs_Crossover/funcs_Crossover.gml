#macro CROSSOVER_SUBDIRECTORY ""

/// @func crossover_get_directory()
/// @desc Returns the directory with the crossover data.
/// @returns {String}
function crossover_get_directory() {
    if (!is_string(CROSSOVER_SUBDIRECTORY) || CROSSOVER_SUBDIRECTORY == "")
        throw "The crossover subdirectory must be a non-empty string.";
    
    return environment_get_variable("localappdata") + "\\" + CROSSOVER_SUBDIRECTORY;
}

/// @func crossover_load_string(filename)
/// @desc Loads a string from the given crossover file, or returns undefined if such a file couldn't be read.
/// @arg {String} filename      The name of the file to load.
/// @returns {String,Undefined}
function crossover_load_string(_filename) {
    var _path = crossover_get_directory() + "\\" + _filename;
    
    var _buffer;
    try {    
        _buffer = buffer_load(_path);
    } catch (ex) {
        return undefined;
    }
    var _result = buffer_read(_buffer, buffer_string);
    buffer_delete(_buffer);
    return _result;
}

/// @func crossover_save_string(filename,content)
/// @desc Saves a string to the given crossover file.
/// @arg {String} filename      The name of the file to save.
/// @arg {String} content       The content to save.
function crossover_save_string(_filename, _content) {
    var _path = crossover_get_directory() + "\\" + _filename;
    
    var _buffer = buffer_create(string_length(_content), buffer_grow, 1);
    buffer_write(_buffer, buffer_string, _content);
    buffer_save(_buffer, _path);
    buffer_delete(_buffer);
}

/// @func crossover_load_number(filename)
/// @desc Loads a number from the given crossover file, or returns 0 0 if such a file couldn't be read.
/// @arg {String} filename      The name of the file to load.
/// @returns {Real}
function crossover_load_number(_filename) {
    var _content = crossover_load_string(_filename);
    if (is_undefined(_content))
        return 0;
    
    return real(_content);
}

/// @func crossover_save_number(filename,number)
/// @desc Saves a number to the given crossover file.
/// @arg {String} filename      The name of the file to save.
/// @arg {Real} number          The number to save.
function crossover_save_number(_filename, _number) {
    crossover_save_string(_filename, string(_number));
}

/// @func crossover_save_max(filename,number)
/// @desc Saves a number to the given crossover file, unless a same or greater number is already saved.
/// @arg {String} filename      The name of the file to save.
/// @arg {Real} number          The number to save.
function crossover_save_max(_filename, _number) {
    var _current = crossover_load_number(_filename);
    if (_current >= _number)
        return;
    
    crossover_save_string(_filename, string(_number));
}

/// @func crossover_load_json(filename)
/// @desc Loads a JSON-parsed value from the given crossover file, or returns undefined if a valid JSON file couldn't be read.
/// @arg {String} filename      The name of the file to load.
/// @returns {Any}
function crossover_load_json(_filename) {
    var _content = crossover_load_string(_filename);
    if (is_undefined(_content))
        return undefined;
    
    try {
        return json_parse(_content);
    } catch (_) {
        // if the file content isn't a valid JSON, prevent crash and return undefined instead
        return undefined;
    }
}

/// @func crossover_save_json(filename,value)
/// @desc Saves a value as JSON to the given crossover file.
/// @arg {String} filename      The name of the file to save.
/// @arg {Any} value            The value to save.
/// @returns {String}
function crossover_save_json(_filename, _value) {
    crossover_save_string(_filename, json_stringify(_value));
}
