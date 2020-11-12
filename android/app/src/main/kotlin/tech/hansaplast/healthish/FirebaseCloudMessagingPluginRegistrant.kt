package tech.hansaplast.healthish

import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin
import io.flutter.plugin.common.PluginRegistry

object FirebaseCloudMessagingPluginRegistrant {
    fun registerWith(registry: PluginRegistry) {
        if (alreadyRegisteredWith(registry)) {
            return
        }
        FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
    }

    private fun alreadyRegisteredWith(registry: PluginRegistry): Boolean {
        val key: String = FirebaseCloudMessagingPluginRegistrant::class.java.getCanonicalName()
        if (registry.hasPlugin(key)) {
            return true
        }
        registry.registrarFor(key)
        return false
    }
}