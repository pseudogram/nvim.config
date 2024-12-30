local enterprise_url = os.getenv("ENTERPRISE_GIT_URL")

if not enterprise_url then
    return {}
end

return {
    "tpope/vim-rhubarb",
    config = function()
        vim.g.github_enterprise_urls = {enterprise_url}
    end
}
