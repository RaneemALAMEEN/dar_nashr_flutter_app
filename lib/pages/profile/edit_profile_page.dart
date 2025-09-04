// import 'package:dar_nashr/services/profile_service.dart';
// import 'package:flutter/material.dart';


// class EditProfilePage extends StatefulWidget {
//   final Map<String, dynamic> profile;

//   const EditProfilePage({super.key, required this.profile});

//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   final ProfileService _profileService = ProfileService();
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController _bioController;
//   late TextEditingController _socialLinksController;

//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _bioController = TextEditingController(text: widget.profile['bio'] ?? '');
//     _socialLinksController =
//         TextEditingController(text: widget.profile['social_links'] ?? '');
//   }

//   Future<void> _saveProfile() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => isLoading = true);

//     try {
//       await _profileService.updateProfile(
//         bio: _bioController.text.trim(),
//         socialLinks: _socialLinksController.text.trim(),
//       );

//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("تم تحديث الملف الشخصي ✅"),
//           backgroundColor: Colors.green,
//         ),
//       );
//       Navigator.pop(context, true); // رجع لصفحة البروفايل
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("فشل التحديث ❌"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("تعديل الملف الشخصي")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _bioController,
//                 decoration: const InputDecoration(
//                   labelText: "نبذة عني",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _socialLinksController,
//                 decoration: const InputDecoration(
//                   labelText: "روابط التواصل",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton.icon(
//                   onPressed: isLoading ? null : _saveProfile,
//                   icon: const Icon(Icons.save),
//                   label: isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text("حفظ"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:dar_nashr/services/profile_service.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> profile;

  const EditProfilePage({super.key, required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ProfileService _profileService = ProfileService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _bioController;
  late TextEditingController _socialLinksController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController(text: widget.profile['bio'] ?? '');
    _socialLinksController =
        TextEditingController(text: widget.profile['social_links'] ?? '');
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await _profileService.updateProfile(
        bio: _bioController.text.trim(),
        socialLinks: _socialLinksController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تم تحديث الملف الشخصي ✅"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true); // رجع لصفحة البروفايل
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("فشل التحديث ❌"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تعديل الملف الشخصي")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: "نبذة عني",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _socialLinksController,
                decoration: const InputDecoration(
                  labelText: "روابط التواصل",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : _saveProfile,
                  icon: const Icon(Icons.save),
                  label: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("حفظ"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
