string.replace = function (str, target, replacement, count)
    count = count or 1
    local escaped_target = string.gsub(target, "[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
    local escaped_replacement = string.gsub(replacement, "%%", "%%%%")
    if count <= 0 then
        return string.gsub(str, escaped_target, escaped_replacement)
    end
    return string.gsub(str, escaped_target, escaped_replacement, count)
end