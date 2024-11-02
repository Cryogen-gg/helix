local PLUGIN = PLUGIN

PLUGIN.name = "Kill Money"
PLUGIN.description = "Adds configurable pay for npcs and players"
PLUGIN.author = "Froggles"
PLUGIN.schema = "Any"

PLUGIN.npc_bounty_default = 25
PLUGIN.npc_bounties = {}

PLUGIN.faction_bounty_default = 100
PLUGIN.faction_bounties = {}
PLUGIN.faction_bounties[FACTION_BOUNTY_HUNTERS] = {
    [FACTION_SENATE] = 10000,
    [FACTION_JEFI] = 7500,
    [FACTION_FLEET] = 5000,
    [FACTION_501ST] = 1000,
    [FACTION_327TH] = 1000,
    [FACTION_104TH] = 1000,
}

hook.Add( "OnNPCKilled", "ixKillMoney_NPCBounties", function( npc, attacker, inflictor )
    local attackerCharacter = attacker:GetCharacter()
    if not attackerCharacter then return end

    local bounty = PLUGIN.npc_bounties[npc:GetClass()] or PLUGIN.npc_bounty_default

    attackerCharacter:GiveMoney(bounty)
end)

hook.Add( "PlayerDeath", "ixKillMoney_FactionBounties", function( victim, inflictor, attacker )
    local victimCharacter = victim:GetCharacter()
    if not victimCharacter then return end

    local attackerCharacter = attacker:GetCharacter()
    if not attackerCharacter then return end

    local attackerFaction = attackerCharacter:GetFaction()
    local attackerBounties = PLUGIN.faction_bounties[attackerFaction] or {}

    local victimFaction = victimCharacter:GetFaction()
    local victimBounty = attackerBounties[vitctimFaction] or PLUGIN.faction_bounty_default
    
    attackerCharacter:GiveMoney(victimBounty)
end )